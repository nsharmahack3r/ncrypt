import 'dart:convert';
import 'package:isar/isar.dart';
part 'message.g.dart';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));
String messageToJson(Message data) => json.encode(data.toJson());
@collection
class Message {
  Message({
      this.text, 
      this.sender,});

  Message.fromJson(dynamic json) {
    text = json['text'];
    sender = json['sender'];
  }
  Id? internalId;
  String? text;
  String? sender;
Message copyWith({  String? text,
  String? sender,
}) => Message(  text: text ?? this.text,
  sender: sender ?? this.sender,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['sender'] = sender;
    return map;
  }
}