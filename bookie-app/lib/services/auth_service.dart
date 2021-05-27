import 'package:bookie/app/locator.dart';
import 'package:bookie/models/user.dart';
import 'package:bookie/services/http_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthService {
  User _user;
  final _httpService = locator<HttpService>();

  User get user => _user;

  bool get hasUser {
    return _user != null;
  }

/*
    "email": "abc@abc.com",
        "password": "abc1234",
 */
  Future<bool> login({String email, String password}) async {
    try {
      final response = await _httpService.post(path: 'auth/login', body: {
        "email": email,
        "password": password,
      });
      if (response == null) {
        return false;
      }

      print('AuthService.login response is $response');
      final token = response["jwtToken"] ?? null;
      _httpService.setToken(token);
      return true;
    } catch (e) {
      print('AuthService.login e: $e');
      return false;
    }
  }

  Future<bool> register(
      {String fullName,
      int age,
      String phone,
      String email,
      String password}) async {
    try {
      final response = await _httpService.post(path: 'auth/register', body: {
        "email": email,
        "password": password,
        "fullname": fullName,
        "age": age,
        "phone": phone,
        "addressId": 34
      });

      if (response == null) {
        return false;
      }
      print('AuthService.register response is ${response}');
      final token = response["loginResource"]["jwtToken"] ?? null;
      _httpService.setToken(token);

      return true;
    } catch (e) {
      print('AuthService.register e: $e');
      return false;
    }
  }

  Future<User> getUserDetails() async {
    try {
      final res = await _httpService.get(path: "user/me");
      if (res == null) {
        return null;
      }
      return User.fromJson(res);
    } catch (e) {
      print('AuthService.getUserDetails e: $e');
      return null;
    }
  }

  void logout() {
    _httpService.setToken(null);
  }
}
