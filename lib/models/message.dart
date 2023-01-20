import 'dart:convert';
import 'package:isar/isar.dart';
part 'message.g.dart';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));
String messageToJson(Message data) => json.encode(data.toJson());
@collection
class Message {
  Message({
      required this.text,
      required this.sender,
      required this.sentAt,
      required this.receiver,
  });

  factory Message.fromJson(dynamic json) => Message(
    text: json['message'],
    sender: json['sender'],
    sentAt: DateTime.parse(json['sentAt']),
    receiver: json['receiver'],
  );


  Id? internalId;
  String text;
  String sender;
  String receiver;
  DateTime sentAt;
Message copyWith({  String? text,
  String? sender, DateTime? sentAt, String? receiver
}) => Message(
    text: text ?? this.text,
    sender: sender ?? this.sender,
    sentAt: sentAt ?? this.sentAt,
    receiver: receiver ?? this.receiver,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = text;
    map['sender'] = sender;
    map['sentAt'] = sentAt.toIso8601String();
    map['receiver'] = receiver;
    return map;
  }
}