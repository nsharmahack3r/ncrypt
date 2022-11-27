import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ncrypt/models/user.dart';
import 'package:ncrypt/service/api_service.dart';
import 'package:ncrypt/values/endpoints.dart';

import '../models/failure.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(service: ApiService());
});

class UserRepository{
  final ApiService _service;

  UserRepository({required ApiService service}): _service = service;

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
}