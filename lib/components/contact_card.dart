import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ncrypt/components/profile_image.dart';

import '../models/user.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      onPressed: (){
        context.replace('/chat', extra: user);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ProfileImage(size: 50,),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${user.name}", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10,),
              Text("@${user.username}", style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
