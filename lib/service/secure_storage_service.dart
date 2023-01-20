import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

final secureStorageProvider = Provider<SecureStorage>((ref)=>SecureStorage());

class SecureStorage{

  final String _key = "USER_KEY";
  Future<User?> getUser() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final String? val = sharedPrefs.getString(_key);
    if(val!=null){
      try{
        return User.fromJson(jsonDecode(val));
      }catch(e) {
        return null;
      }
    }
    return null;
  }

  void saveUser(User user) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final String val = jsonEncode(user.toJson());
    await sharedPrefs.setString(_key, val);
  }

  void deleteAll() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.clear();
  }
}