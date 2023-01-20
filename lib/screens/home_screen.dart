import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ncrypt/components/profile_image.dart';
import 'package:ncrypt/controller/auth_controller.dart';
import 'package:ncrypt/screens/chat_menu.dart';
import '../components/drawer.dart';
import '../models/user.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      //final message = Message.fromJson(event.data);
      final user = User.fromJson(event.data);
      context.push('/chat', extra:user);

      if(event == null){
        final eventMessage = await  FirebaseMessaging.instance.getInitialMessage();
        if(eventMessage!=null){
          final user = User.fromJson(eventMessage.data);
          context.push('/chat', extra: user);
        }
      }

    });

    // final eventMessage = await  FirebaseMessaging.instance.getInitialMessage();
    // if(eventMessage!=null){
    //   final user = User.fromJson(eventMessage.data);
    //   context.push('/chat', extra: user);
    // }

    final user = ref.watch(userProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          title: const Text("Ncrypt"),
          centerTitle: false,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Chats",
              ),
              Tab(
                text: "Groups",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const ContactList(),
            Container(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push('/findUsers');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
