import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';
import 'package:ncrypt/components/message_card.dart';
import 'package:ncrypt/controller/auth_controller.dart';
import 'package:ncrypt/models/message.dart';
import 'package:ncrypt/repository/message_respository.dart';
import 'package:ncrypt/service/local_db.dart';
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
  final db = LocalDBService();

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
            Expanded(child: ChatMessageList(user: widget.user,),),
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
      final res = await ref.read(messageRepositoryProvider).sendMessage(from: "${currentUser!.uid}", to: "${widget.user.uid}", message: messageController.text);
      if(res){
        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Message sent!")));
        db.handleOutgoingMessage(
            Message(text: messageController.text, sender: currentUser!.uid, sentAt: DateTime.now(), receiver: widget.user.uid),
            widget.user,
        );
        messageController.text = '';
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to send message")));
      }
    }
  }
}

class ChatMessageList extends StatelessWidget {
  const ChatMessageList ({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final db = LocalDBService();
    return StreamBuilder(
      stream: db.listenToMessagesFromUser(user),
      builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
        if(snapshot.hasData){
          return ImplicitlyAnimatedList(
            //itemCount: snapshot.data!.length,
            itemData: snapshot.data!,
            itemBuilder: (context, message) => MessageCard(message: message as Message),
            reverse: true,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
