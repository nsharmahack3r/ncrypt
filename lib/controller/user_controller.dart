import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ncrypt/repository/user_repository.dart';

import '../models/user.dart';
import 'auth_controller.dart';

final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  final userRepo = ref.watch(userRepositoryProvider);
  final currentUser = ref.watch(userProvider);
  final users =  await userRepo.allUsers();
  users.removeWhere((element) => element.id == currentUser!.id);
  return users;
});

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

}