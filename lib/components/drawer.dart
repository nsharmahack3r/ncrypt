import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ncrypt/components/profile_image.dart';

import '../controller/auth_controller.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Drawer(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: ()=>Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back)
              ),
            ],
          ),
          UserAccountsDrawerHeader(
            currentAccountPicture: ProfileImage(url: user!.avatar, size: 60,),
            accountName: Text('${user.name}'),
            accountEmail: Text('${user.username}'),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: (){
              ref.read(authControllerProvider.notifier).logout();
            },
          ),
        ],
      ),
    );
  }
}