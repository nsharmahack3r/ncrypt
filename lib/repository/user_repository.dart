import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';
import 'package:ncrypt/models/user.dart';
import 'package:ncrypt/service/api_service.dart';
import 'package:ncrypt/values/endpoints.dart';

import '../models/failure.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(service: ApiService(), ref: ref);
});

final contactsProvider = StateProvider((ref) {
  final List<User> contacts = [];
  return contacts;
});

class UserRepository{
  final ApiService _service;
  final Ref _ref;
  UserRepository({required ApiService service, required Ref ref}): _service = service, _ref = ref;

  Future<List<User>> allUsers() async {
    Either<Failure, dynamic> result = await _service.getRequest(url: ApiEndPoints.allUsers);
    return result.fold(
            (Failure failure){
              if(kDebugMode){
                print(failure.message);
              }
              return [];
            },
            (r){
                final List<User> users = [];
                for(var user in r['users']) {
                  users.add(User.fromJson(user));
                }
                return users;
            },
    );
  }

  Future<List<User>> getContacts() async {
    final isar = await Isar.open([UserSchema]);
    final users = await isar.users.where().limit(50).findAll();
    return users;
  }

  Future<void> addContact({required User contact}) async {
    final isar = await Isar.open([UserSchema]);
    _ref.read(contactsProvider.notifier).update((state) => [...state,contact]);
    await isar.users.put(contact);
  }
}