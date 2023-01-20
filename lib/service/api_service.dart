import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import '../models/failure.dart';

class ApiService{
  Either<Failure, dynamic> _returnAPIResult(http.Response response) {
    try {
      final data = jsonDecode(response.body);
      if(data['error'] != null){
        return Left(Failure(message: data['error']));
      }
      return Right(jsonDecode(response.body));
    } on FormatException {
      return Left(Failure(message: "Failed to Format"));
    }
  }

  Future<Either<Failure, dynamic>> getRequest({required String url, String? token}) async {

    final Map<String, String> requestHeaders = {
      "Content-Type":"application/json",
      "Authorization": "$token"
    };

    if(kDebugMode){
      log('GET API HIT ==> $url');
    }
    try {
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if(kDebugMode){
        log('RESPONSE ==> ${response.body}');
      }
      return _returnAPIResult(response);
    } on SocketException{
      return Left(Failure(message: "Failed to send request"));
    } catch(e) {
      return Left(Failure(message: "Unknown Error"));
    }
  }

  Future<Either<Failure, dynamic>> postRequest({required String url, Map<String,dynamic>? body, String? token}) async {

    final Map<String, String> requestHeaders = {
      "Content-Type":"application/json",
      //"Authorization": "$token"
    };

    if(kDebugMode){
      log('POST API HIT ==> $url');
    }
    try {
      final response = await http.post(Uri.parse(url), headers: requestHeaders, body: jsonEncode(body));
      print(response.body);
      if(kDebugMode){
        log("RESPONSE : ${response.body}");
      }
      return _returnAPIResult(response);
    } on SocketException{
      return Left(Failure(message: "Failed to send request"));
    } catch(e) {
      return Left(Failure(message: "Unknown Error"));
    }
  }

  Future<Either<Failure, dynamic>> patchRequest({required String url, Map<String,dynamic>? body, String? token}) async {

    final Map<String, String> requestHeaders = {
      "Content-Type":"application/json",
      "Authorization": "$token"
    };

    if(kDebugMode){
      log('PATCH API HIT ==> $url');
    }
    try {
      final response = await http.patch(Uri.parse(url), headers: requestHeaders);
      return _returnAPIResult(response);
    } on SocketException{
      return Left(Failure(message: "Failed to send request"));
    } catch(e) {

      return Left(Failure(message: "Unknown Error"));
    }
  }
}