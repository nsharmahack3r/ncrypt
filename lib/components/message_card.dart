import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ncrypt/models/message.dart';

import '../controller/auth_controller.dart';

class MessageCard extends ConsumerWidget {
  const MessageCard({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RegExp REGEX_EMOJI = RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

    final Iterable<Match> matches = REGEX_EMOJI.allMatches('${message.text}');
    final currentUser = ref.read(userProvider)!;
    final sentByMe = message.sender == currentUser.uid;

    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      title: Align(
        alignment: sentByMe?Alignment.centerRight:Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Container(
            //margin: EdgeInsets.only(left: sentByMe ? 60 : 0, right: sentByMe ? 0 : 60,),
            padding: matches.isNotEmpty ? const EdgeInsets.all(4) : const EdgeInsets.all(8),
            decoration: sentByMe ? const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)
                )
            ) : const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                )
            ),
            child: matches.isEmpty? Text(
              '${message.text}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0
              ),
            ):RichText(
                text: TextSpan(children: [
                  for (var t in message.text!.characters)
                    TextSpan(
                        text: t,
                        style: TextStyle(
                          fontSize: REGEX_EMOJI.allMatches(t).isNotEmpty ? 22.0 : 16.0,
                          color: Colors.white,
                        )),
                ])),
          ),
        ),
      ),
    );
  }
}
