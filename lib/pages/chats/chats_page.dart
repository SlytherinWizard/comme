import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Chats Page"),
          TextButton(onPressed: () {}, child: Text("Next step")),
          Row(),
        ],
      ),
    );
  }
}
