import 'package:flutter/material.dart';
import 'package:ncrypt/components/profile_image.dart';

import '../models/user.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              ProfileImage(url: user.avatar, size: 60,),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${user.name}", style: const TextStyle(fontSize: 16),),
                  const SizedBox(height: 6,),
                  const Text("online", style: TextStyle(color: Colors.green),),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: (){
                  // Navigator.of(context).pop();
                },
                icon: Icon(Icons.video_camera_front_outlined, size: 30,),
              ),
              IconButton(
                onPressed: (){
                  // Navigator.of(context).pop();
                },
                icon: Icon(Icons.call_outlined),
              ),
            ],
          )
        ],
      ),
    );
  }
}
