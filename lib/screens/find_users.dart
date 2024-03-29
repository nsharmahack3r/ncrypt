import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/contact_card.dart';
import '../components/thread.dart';
import '../controller/user_controller.dart';
import '../models/user.dart';

class FindUsers extends ConsumerStatefulWidget {
  const FindUsers({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _FindUsersState();
}

class _FindUsersState extends ConsumerState<FindUsers> {

  @override
  Widget build(BuildContext context) {

    final usersFuture = ref.watch(userListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Users'),
      ),
      body: usersFuture.map(
          data: (users) => ListView.builder(
            itemCount: users.value.length,
            itemBuilder: (context, index) => ContactCard(user: users.value[index]),
          ),
          error: (err)=> const Text("Failed To load users"),
          loading: (list) => const Center(child: CircularProgressIndicator(),),
      ),
    );
  }

  void addUser(User user){
    ref.read(userControllerProvider.notifier).addContact(user, context);
  }
}
