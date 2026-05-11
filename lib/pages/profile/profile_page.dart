import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Profile Page"),
          TextButton(onPressed: () {}, child: Text("Next step")),
          Row(),
        ],
      ),
    );
  }
}
