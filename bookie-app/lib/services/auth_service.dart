import 'package:bookie/app/locator.dart';
import 'package:bookie/models/user.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthService {
  User _user;

  User get user => _user;

  bool get hasUser {
    return _user != null;
  }

  Future<bool> login({String email, String password}) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      _user = User(name: "test", surname: "test");
      return true;
    } catch (e) {
      print('AuthService.login e: $e');
      return false;
    }
  }

  Future<bool> register({String email, String password}) async {
    try {
      await Future.delayed(Duration(seconds: 2));

      return true;
    } catch (e) {
      print('AuthService.register e: $e');
      return false;
    }
  }
}
