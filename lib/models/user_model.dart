import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final bool emailVerified;
  final DateTime createdAt;
  final DateTime? lastSignIn;
  final bool isActive;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.emailVerified = false,
    required this.createdAt,
    this.lastSignIn,
    this.isActive = true,
  });

  /// Create UserModel from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('User document is empty');
    }

    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'],
      photoUrl: data['photoUrl'],
      emailVerified: data['emailVerified'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastSignIn: data['lastSignIn'] != null
          ? (data['lastSignIn'] as Timestamp).toDate()
          : null,
      isActive: data['isActive'] ?? true,
    );
  }

  /// Convert UserModel to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'emailVerified': emailVerified,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastSignIn': lastSignIn != null ? Timestamp.fromDate(lastSignIn!) : null,
      'isActive': isActive,
    };
  }

  /// Create a copy with modified fields
  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? emailVerified,
    DateTime? createdAt,
    DateTime? lastSignIn,
    bool? isActive,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      emailVerified: emailVerified ?? this.emailVerified,
      createdAt: createdAt ?? this.createdAt,
      lastSignIn: lastSignIn ?? this.lastSignIn,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  String toString() =>
      'UserModel(uid: $uid, email: $email, displayName: $displayName, emailVerified: $emailVerified)';
}
