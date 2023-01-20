import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ncrypt/repository/user_repository.dart';

import '../models/user.dart';
import 'auth_controller.dart';

final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  final userRepo = ref.watch(userRepositoryProvider);
  final currentUser = ref.watch(userProvider);
  final users =  await userRepo.allUsers();
  users.removeWhere((element) => element.uid == currentUser!.uid);
  return users;
});

final contactListProvider = StateProvider<List<User>>((ref) => []);

final userControllerProvider = StateNotifierProvider<UserController, bool>((ref) {
  return UserController(userRepository: ref.watch(userRepositoryProvider), ref: ref);
});

class UserController extends StateNotifier<bool>{
  final UserRepository _userRepository;
  final Ref _ref;

  UserController({
    required UserRepository userRepository,
    required Ref ref
  }): _ref = ref, _userRepository = userRepository, super(false);

  Future<List<User>> getUsers() async {
    state = true;
    final users = await _userRepository.allUsers();
    state = false;
    return users;
  }

  void addContact(User user, BuildContext context){
    _ref.read(userRepositoryProvider).addContact(contact: user);
    _ref.read(contactListProvider.notifier).update((state) => [...state, user]);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("@${user.username} added to contacts.")));
  }
}