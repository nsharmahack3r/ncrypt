import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ncrypt/models/user.dart';
import 'package:ncrypt/service/api_service.dart';
import 'package:ncrypt/service/local_db.dart';
import 'package:ncrypt/values/endpoints.dart';

import '../models/failure.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  //to decode the message sent by the user.

}

final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  return MessageRepository(service: ApiService(), localDBService: LocalDBService());
});

class MessageRepository {
  final ApiService _service;
  final LocalDBService _localDBService;
  MessageRepository({
    required ApiService service,
    required LocalDBService localDBService,
  }) : _service = service, _localDBService = localDBService;
  Future<bool> sendMessage({
    required String from,
    required String to,
    required String message,
  }) async {
    Map<String, String> body = {
      "from": from,
      "to": to,
      "message": message
    };

    Either<Failure, dynamic> result = await _service.postRequest(url: ApiEndPoints.sendMessage, body: body);
    return result.fold((l){
      if(kDebugMode){
        print(l.message);
      }
      return false;
    }, (r){
      final bool result = r['success'] ?? false;
      return result;
    });

  }
}
