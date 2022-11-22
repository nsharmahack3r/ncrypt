import 'package:flutter/material.dart';
import 'package:ncrypt/components/thread.dart';
class ChatMenu extends StatelessWidget {
  const ChatMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) => const ChatThread(),
    );
  }
}
