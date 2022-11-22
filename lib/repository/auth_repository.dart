import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ncrypt/service/api_service.dart';

import '../models/failure.dart';
import '../models/user.dart';
import '../values/endpoints.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(service: ApiService());
});

class AuthRepository{
  ApiService _service;

  AuthRepository({required ApiService service}): _service = service;

  Future<User?> login ({required String email, required String password}) async {
    final body = {
      "email":email,
      "password":password
    };
    Either<Failure, dynamic> result = await _service.postRequest(url: ApiEndPoints.login, body: body);
    return result.fold((l){
      if(kDebugMode){
        print('Error in Auth Login.');
        print(l.message);
        return null;
      }
    }, (r){
      User user = User.fromJson(r['user']);
      user = user.copyWith(jwt:r['jwt']);
      return user;
    });
  }

  Future<User?> signUp ({ required String email, required String password}) async {
    final body = {
      "email":email,
      "password":password
    };
    Either<Failure, dynamic> result = await _service.postRequest(url: ApiEndPoints.signup, body: body);
    return result.fold((l){
      if(kDebugMode){
        print('Error in Auth Login.');
        print(l.message);
        return null;
      }
    }, (r){
      User user = User.fromJson(r['user']);
      user = user.copyWith(jwt:r['jwt']);
      return user;
    });
  }
  void logOut() async {
    
  }
}