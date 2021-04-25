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

  Future<User> login({String email, String password}) async {
    try {
      return User(name: "TestName", surname: "TestSurname");
    } catch (e) {
      throw Exception();
    }
  }
}
