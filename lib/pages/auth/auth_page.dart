import 'package:comme/cubits/login/login_cubit.dart';
import 'package:comme/cubits/signup/signup_cubit.dart';
import 'package:comme/pages/auth/views/login/login_view.dart';
import 'package:comme/pages/auth/views/signup/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
        BlocProvider<SignupCubit>(create: (context) => SignupCubit()),
      ],
      child: Scaffold(
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
      ),
    );
  }
}
