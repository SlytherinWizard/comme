import 'package:comme/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              context.pop();
            },
            child: Text("Next step"),
          ),
          Row(),
        ],
      ),
    );
  }
}
