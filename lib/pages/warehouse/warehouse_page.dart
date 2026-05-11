import 'package:flutter/material.dart';

class WarehousePage extends StatelessWidget {
  const WarehousePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Warehouse Page"),
          TextButton(onPressed: () {}, child: Text("Next step")),
          Row(),
        ],
      ),
    );
  }
}
