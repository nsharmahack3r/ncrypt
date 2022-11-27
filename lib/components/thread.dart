import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ncrypt/components/profile_image.dart';
import '../models/user.dart';

class ChatThread extends StatelessWidget {
  const ChatThread({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      onPressed: () {
        //context.push('/chat', extra: user.toJson());
        //GoRouter.of(context).pushNamed('chat', params: user.toJson());
        context.push('/chat', extra: user);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ClipOval(
            child: ProfileImage(size: 50,),
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width - 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("@${user.username}", style: const TextStyle(fontSize: 16)),
                    const Text("09:00", style: TextStyle(fontSize: 12),)
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                  width: size.width - 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Message to the user"),
                      //unseenCount(),
                    ],
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
