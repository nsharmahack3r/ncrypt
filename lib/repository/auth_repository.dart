import 'package:firebase_messaging/firebase_messaging.dart';
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
  final ApiService _service;

  AuthRepository({required ApiService service}): _service = service;

  Future<User?> login ({required String email, required String password}) async {
    final Map<String, String> body = {
      "email":email,
      "password":password,
      "fcmToken": "${ await FirebaseMessaging.instance.getToken() }"
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

  Future<User?> signUp ({
    required String email,
    required String password,
    required String name,
    required String username
  }) async {
    final Map<String, String> body = {
      "email":email,
      "password":password,
      "fcmToken": "${ await FirebaseMessaging.instance.getToken() }",
      "name": name,
      "username": username
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
    print("User logged out.");
  }
}