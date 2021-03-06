import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@lazySingleton
class HttpService {
  static const url = "http://comaristan.cf:8080/";

  String _token;

  Future<dynamic> get({String path, String queryParams}) async {
    try {
      if (queryParams != null) {
        path += queryParams;
      }
      Uri uri = Uri.parse(url + path);
      print('HttpService.get uri: $uri');
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          if (_token != null) HttpHeaders.authorizationHeader: "Bearer $_token"
        },
      );
      final data = jsonDecode(utf8.decode(response.bodyBytes));
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
      if (response == null || response?.statusCode > 200) {
        return null;
      }
      final data = jsonDecode(utf8.decode(response.bodyBytes));
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

  Future<dynamic> delete({String path, String queryParams}) async {
    try {
      if (queryParams != null) {
        path += queryParams;
      }
      Uri uri = Uri.parse(url + path);
      print('HttpService.delete uri: $uri');
      final response = await http.delete(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          if (_token != null) HttpHeaders.authorizationHeader: "Bearer $_token"
        },
      );
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      print('HttpService.delete e: $e');
      return null;
    }
  }

  Future<dynamic> put({String path, Map<String, dynamic> body}) async {
    try {
      final uri = Uri.parse(url + path);
      print("uri is $uri");
      final response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          if (_token != null) HttpHeaders.authorizationHeader: "Bearer $_token"
        },
      );
      print(
          "response is $response | ${response.statusCode} | ${response.body}");
      if (response == null || response?.statusCode > 200) {
        return null;
      }
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      // print('HttpService.post e: $e');
      return null;
    }
  }
}
