import 'package:comme/pages/auth/views/login/login_view.dart';
import 'package:comme/pages/auth/views/signup/signup_view.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const BouncingScrollPhysics(),
              children: [LoginView(), SignupView()],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Next step"),
          ),
        ],
      ),
    );
  }
}
