import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Orders Page"),
          TextButton(onPressed: () {}, child: Text("Next step")),
          Row(),
        ],
      ),
    );
  }
}
