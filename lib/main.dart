import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ncrypt/service/secure_storage_service.dart';
import 'package:routemaster/routemaster.dart';
import 'controller/auth_controller.dart';
import 'models/user.dart';
import 'routes.dart';

void main() {
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
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
        final User? user = ref.watch(userProvider);
        if (user != null) {
          return loggedInRoute;
        }
        return loggedOutRoute;
      }),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
