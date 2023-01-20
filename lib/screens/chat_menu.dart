import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';
import 'package:ncrypt/components/thread.dart';
import 'package:ncrypt/controller/user_controller.dart';
import 'package:ncrypt/service/local_db.dart';

import '../models/user.dart';


class ContactList extends ConsumerWidget {
  const ContactList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

   // final List<User> contacts = ref.watch(contactListProvider);
    final dbService = LocalDBService();

    return StreamBuilder(
      stream: dbService.listenToUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if(snapshot.hasData){
          return ImplicitlyAnimatedList(
            //itemCount: snapshot.data!.length,
            itemData: snapshot.data!,
            itemBuilder: (context, user) => ChatThread(user: user as User,),
          );
        } else {
          return Container();
        }

      },
    );
  }
}
