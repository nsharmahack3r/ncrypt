import 'package:flutter/material.dart';
import 'package:ncrypt/components/thread.dart';

import '../models/user.dart';
class ChatMenu extends StatelessWidget {
  const ChatMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) => ChatThread(user: User(),),
    );
  }
}
