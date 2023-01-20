import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ncrypt/models/message.dart';
import 'package:ncrypt/service/local_db.dart';
import 'package:ncrypt/service/secure_storage_service.dart';
import 'controller/auth_controller.dart';
import 'models/user.dart';
import 'routes.dart';

Future<void> onBackgroundMessage(RemoteMessage event) async {
  final message = Message.fromJson(event.data);
  final user = User.fromJson(event.data);

  final dbService = LocalDBService();
  dbService.handleIncomingMessage(message, user);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

  FirebaseMessaging.onMessage.listen((event) async {
    final message = Message.fromJson(event.data);
    final user = User.fromJson(event.data);

    final dbService = LocalDBService();
    dbService.handleIncomingMessage(message, user);

    print(user.toJson());
    print(message.toJson());
  });

  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerStatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {

  @override
  void initState() {
    super.initState();
    initUser();
  }

  void initUser(){
    SecureStorage().getUser().then((User? currentUser){
      ref.read(userProvider.notifier).update((state) => currentUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'N-crypt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
      ),
     routerConfig: ref.watch(userProvider) != null ? authRouter : noAuthRouter,
    );
  }
}
