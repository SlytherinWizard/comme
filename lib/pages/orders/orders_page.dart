import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

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
