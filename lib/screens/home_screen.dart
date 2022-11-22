import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ncrypt/components/profile_image.dart';
import 'package:ncrypt/controller/auth_controller.dart';
import 'package:ncrypt/screens/chat_menu.dart';

import '../components/drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            const ChatMenu(),
            Container(),
          ],

        ),
      ),
    );
  }
}
