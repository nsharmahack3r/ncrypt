import 'dart:convert';

import 'package:isar/isar.dart';

part 'user.g.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

@collection
class User {
  User({
      this.jwt, 
      this.id,
      this.email,
      this.name,
      this.username,
      this.avatar,
  });

  User.fromJson(dynamic json) {
    jwt = json['jwt'];
    id = json['_id'];
    email = json['email'];
    name = json['name'];
    username = json['username'];
    avatar = json['avatar'];
  }
  Id? internalId;
  String? jwt;
  String? id;
  String? email;
  String? name;
  String? username;
  String? avatar;

User copyWith({
  String? jwt,
  String? id,
  String? email,
  String? name,
  String? username,
  String? avatar

}) => User(
  jwt: jwt ?? this.jwt,
  id: id ?? this.id,
  email: email ?? this.email,
  name: name ?? this.name,
  username: username ?? this.username,
  avatar : avatar ?? this.avatar,
);
  Map<String, String> toJson() {
    final map = <String, String>{};
    map['jwt'] = '$jwt';
    map['_id'] = "$id";
    map['email'] = "$email";
    map['username'] = "$username";
    map['name'] = "$name";
    map['avatar'] = "$avatar";
    return map;
  }
}