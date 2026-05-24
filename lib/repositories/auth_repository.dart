import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:comme/models/user_model.dart';
import 'package:comme/utils/auth_exception.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  /// Get the current authenticated user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Get current user as stream for real-time updates
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Get current user model from Firestore
  Future<UserModel?> getCurrentUserModel() async {
    try {
      final user = currentUser;
      if (user == null) return null;

      final doc = await _firebaseFirestore.collection('users').doc(user.uid).get();
      if (!doc.exists) return null;

      return UserModel.fromFirestore(doc);
    } catch (e) {
      throw AuthException(message: 'Failed to get user data: $e');
    }
  }

  /// Get user model stream for real-time updates
  Stream<UserModel?> getUserModelStream() {
    return authStateChanges.asyncExpand((user) {
      if (user == null) {
        return Stream.value(null);
      }
      return _firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((doc) {
            if (!doc.exists) return null;
            return UserModel.fromFirestore(doc);
          });
    });
  }

  /// Sign up with email and password
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      // Create user account
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw AuthException(message: 'Failed to create user account');
      }

      // Update display name if provided
      if (displayName != null && displayName.isNotEmpty) {
        await user.updateDisplayName(displayName);
        await user.reload();
      }

      // Create user document in Firestore
      final userModel = UserModel(
        uid: user.uid,
        email: user.email ?? '',
        displayName: displayName ?? user.displayName,
        photoUrl: user.photoURL,
        emailVerified: user.emailVerified,
        createdAt: DateTime.now(),
        lastSignIn: user.metadata.lastSignInTime,
        isActive: true,
      );

      await _firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toFirestore());

      // Send email verification
      await sendEmailVerification();

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseCode(e.code, e.message ?? '');
    } catch (e) {
      throw AuthException(message: 'Sign up failed: $e');
    }
  }

  /// Sign in with email and password
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw AuthException(message: 'Failed to sign in');
      }

      // Update last sign in time in Firestore
      await _firebaseFirestore.collection('users').doc(user.uid).update({
        'lastSignIn': Timestamp.fromDate(DateTime.now()),
      });

      // Get and return user model
      final userModel = await getCurrentUserModel();
      if (userModel == null) {
        throw AuthException(message: 'User data not found');
      }

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseCode(e.code, e.message ?? '');
    } catch (e) {
      throw AuthException(message: 'Sign in failed: $e');
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException(message: 'Sign out failed: $e');
    }
  }

  /// Send email verification link
  Future<void> sendEmailVerification() async {
    try {
      final user = currentUser;
      if (user == null) {
        throw AuthException(message: 'No user is currently signed in');
      }

      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseCode(e.code, e.message ?? '');
    } catch (e) {
      throw AuthException(message: 'Failed to send verification email: $e');
    }
  }

  /// Check if email is verified
  Future<bool> isEmailVerified() async {
    try {
      final user = currentUser;
      if (user == null) return false;

      await user.reload();
      return user.emailVerified;
    } catch (e) {
      throw AuthException(message: 'Failed to check email verification: $e');
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseCode(e.code, e.message ?? '');
    } catch (e) {
      throw AuthException(message: 'Failed to send password reset email: $e');
    }
  }

  // /// Confirm password reset with code and new password
  // Future<void> confirmPasswordReset({
  //   required String code,
  //   required String newPassword,
  // }) async {
  //   try {
  //     await _firebaseAuth.confirmPasswordReset(
  //       code: code,
  //       newPassword: newPassword,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     throw AuthException.fromFirebaseCode(e.code, e.message ?? '');
  //   } catch (e) {
  //     throw AuthException(message: 'Failed to reset password: $e');
  //   }
  // }

  // /// Verify password reset code
  // Future<String> verifyPasswordResetCode(String code) async {
  //   try {
  //     return await _firebaseAuth.verifyPasswordResetCode(code);
  //   } on FirebaseAuthException catch (e) {
  //     throw AuthException.fromFirebaseCode(e.code, e.message ?? '');
  //   } catch (e) {
  //     throw AuthException(message: 'Invalid password reset code: $e');
  //   }
  // }

  /// Update user profile
  Future<void> updateUserProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      final user = currentUser;
      if (user == null) {
        throw AuthException(message: 'No user is currently signed in');
      }

      if (displayName != null && displayName.isNotEmpty) {
        await user.updateDisplayName(displayName);
      }

      if (photoUrl != null && photoUrl.isNotEmpty) {
        await user.updatePhotoURL(photoUrl);
      }

      // Update in Firestore as well
      await _firebaseFirestore.collection('users').doc(user.uid).update({
        if (displayName != null && displayName.isNotEmpty)
          'displayName': displayName,
        if (photoUrl != null && photoUrl.isNotEmpty) 'photoUrl': photoUrl,
      });

      await user.reload();
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseCode(e.code, e.message ?? '');
    } catch (e) {
      throw AuthException(message: 'Failed to update profile: $e');
    }
  }

  // /// Change password
  // Future<void> changePassword(String newPassword) async {
  //   try {
  //     final user = currentUser;
  //     if (user == null) {
  //       throw AuthException(message: 'No user is currently signed in');
  //     }

  //     await user.updatePassword(newPassword);
  //   } on FirebaseAuthException catch (e) {
  //     throw AuthException.fromFirebaseCode(e.code, e.message ?? '');
  //   } catch (e) {
  //     throw AuthException(message: 'Failed to change password: $e');
  //   }
  // }

  /// Delete user account
  Future<void> deleteAccount() async {
    try {
      final user = currentUser;
      if (user == null) {
        throw AuthException(message: 'No user is currently signed in');
      }

      // Delete user document from Firestore
      await _firebaseFirestore.collection('users').doc(user.uid).delete();

      // Delete user account
      await user.delete();
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseCode(e.code, e.message ?? '');
    } catch (e) {
      throw AuthException(message: 'Failed to delete account: $e');
    }
  }

  /// Reauthenticate user (required before sensitive operations)
  Future<void> reauthenticate({
    required String email,
    required String password,
  }) async {
    try {
      final user = currentUser;
      if (user == null) {
        throw AuthException(message: 'No user is currently signed in');
      }

      final credential = EmailAuthProvider.credential(
        email: email.trim(),
        password: password,
      );

      await user.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseCode(e.code, e.message ?? '');
    } catch (e) {
      throw AuthException(message: 'Reauthentication failed: $e');
    }
  }

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  /// Get user ID token (useful for API calls)
  Future<String?> getIdToken({bool forceRefresh = false}) async {
    try {
      final user = currentUser;
      if (user == null) return null;

      return await user.getIdToken(forceRefresh);
    } catch (e) {
      throw AuthException(message: 'Failed to get ID token: $e');
    }
  }
}
