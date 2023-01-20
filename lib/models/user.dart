import 'dart:convert';

import 'package:isar/isar.dart';

part 'user.g.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

@collection
class User {
  User({
      this.jwt, 
      required this.uid,
      required this.email,
      required this.name,
      required this.username,
      this.avatar,
      this.lastInteracted,
  });

  factory User.fromJson(dynamic json) => User(
    jwt: json['jwt'],
    uid: json['_id'],
    email: json['email'],
    name: json['name'],
    username: json['username'],
    avatar: json['avatar'],
  );

  Id? internalId;
  String? jwt;
  String uid;
  String email;
  String name;
  String username;
  String? avatar;
  DateTime? lastInteracted;

User copyWith({
  String? jwt,
  String? id,
  String? email,
  String? name,
  String? username,
  String? avatar,
  DateTime? lastInteracted,

}) => User(
  jwt: jwt ?? this.jwt,
  uid: id ?? this.uid,
  email: email ?? this.email,
  name: name ?? this.name,
  username: username ?? this.username,
  avatar : avatar ?? this.avatar,
  lastInteracted: lastInteracted ?? this.lastInteracted,
);
  Map<String, String> toJson() {
    final map = <String, String>{};
    map['jwt'] = '$jwt';
    map['_id'] = "$uid";
    map['email'] = "$email";
    map['username'] = "$username";
    map['name'] = "$name";
    map['avatar'] = "$avatar";
    return map;
  }
}