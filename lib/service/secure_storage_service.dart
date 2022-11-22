import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user.dart';

final secureStorageProvider = Provider<SecureStorage>((ref)=>SecureStorage());

class SecureStorage{
  final _storage = const FlutterSecureStorage();
  final String _key = "USER_KEY";
  Future<User?> getUser() async {
    final String? val = await _storage.read(key: _key);
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
    final String val = jsonEncode(user.toJson());
    await _storage.write(key: _key, value: val);
  }

  void deleteAll(){
    _storage.deleteAll();
  }
}