import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@lazySingleton
class HttpService {
  static const url = "http://comaristan.cf:8080/";

  String _token;

  Future<dynamic> get({String path, Map<String, dynamic> body}) async {
    try {
      final response = await http.get(
        Uri.parse(url + path),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          if (_token != null) HttpHeaders.authorizationHeader: "Bearer $_token"
        },
      );
      final data = jsonDecode(response.body);
      print('HttpService.get : $data');
      return data;
    } catch (e) {
      print('HttpService.get e: $e');
      return null;
    }
  }

  Future<dynamic> post({String path, Map<String, dynamic> body}) async {
    try {
      final uri = Uri.parse(url + path);
      print("uri is $uri");
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          if (_token != null) HttpHeaders.authorizationHeader: "Bearer $_token"
        },
      );
      /* print(
          "response is $response | ${response.statusCode} | ${response.body}");*/
      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      // print('HttpService.post e: $e');
      return null;
    }
  }

  void setToken(token) {
    _token = token;
    print('HttpService.setToken $token');
  }
}
