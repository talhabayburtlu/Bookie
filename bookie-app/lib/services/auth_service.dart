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
      await Future.delayed(Duration(seconds: 2));
      _user = User.mocked();
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
      print('AuthService.register response is $response');

      if (response == null || response.status > 200) {
        return false;
      }
      return true;
    } catch (e) {
      print('AuthService.register e: $e');
      return false;
    }
  }
}
