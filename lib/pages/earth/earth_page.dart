import 'package:flutter/material.dart';

class EarthPage extends StatelessWidget {
  const EarthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Earth Page"),
          TextButton(
            onPressed: () {
            },
            child: Text("Next step"),
          ),
          Row(),
        ],
      ),
    );
  }
}
