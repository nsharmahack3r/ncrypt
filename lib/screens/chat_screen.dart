import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:ncrypt/controller/auth_controller.dart';
import 'package:ncrypt/repository/message_respository.dart';
import 'package:ncrypt/service/api_service.dart';

import '../components/chat_header.dart';
import '../models/user.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    required this.user,
    Key? key,
  }) : super(key: key);

  final User user;

  @override
  ConsumerState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            ChatHeader(user: widget.user,),
            const SizedBox(height: 10,),
            Expanded(child: Container(),),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type Something...",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(
                    Icons.send,
                    color: Colors.tealAccent,
                  ),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() async {
    if(messageController.text.isNotEmpty){
      final currentUser = ref.read(userProvider);
      final res = await ref.read(messageRepositoryProvider).sendMessage(from: "${currentUser!.id}", to: "${widget.user.id}", message: messageController.text);
      if(res){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Message sent!")));
        messageController.text = '';
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to send message")));
      }
    }
  }
}