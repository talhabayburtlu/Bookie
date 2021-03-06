import 'package:bookie/app/locator.dart';
import 'package:bookie/models/user.dart';
import 'package:bookie/services/http_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:observable_ish/observable_ish.dart';

@lazySingleton
class AuthService with ReactiveServiceMixin {
  final _httpService = locator<HttpService>();

  String email;

  AuthService() {
    listenToReactiveValues([_user]);
  }

  RxValue<User> _user = RxValue<User>(initial: null);

  User get user => _user.value;

  void updateUser(User user) {
    _user.value = user;
  }

  bool get hasUser {
    return _user != null;
  }

/*
    "email": "abc@abc.com",
        "password": "abc1234",
 */
  Future<dynamic> login({String email, String password}) async {
    try {
      final response = await _httpService.post(path: 'auth/login', body: {
        "email": email,
        "password": password,
      });
      print('AuthService.login response is $response');

      if (response == null) {
        return "Something went wrong";
      }

      if (response["jwtToken"] == null) {
        return response["message"] ?? "Something went wrong!";
      }

      final token = response["jwtToken"];
      _httpService.setToken(token);
      getUserDetails();
      return true;
    } catch (e) {
      print('AuthService.login e: $e');
      return false;
    }
  }

  Future<dynamic> register(
      {String fullName,
      int age,
      String phone,
      String email,
      String password,
      int addressId}) async {
    try {
      final response = await _httpService.post(path: 'auth/register', body: {
        "email": email,
        "password": password,
        "fullname": fullName,
        "age": age,
        "phone": phone,
        "addressId": addressId
      });

      print('AuthService.register response is ${response}');

      if (response == null) {
        return "Something went wrong";
      }

      if (response["loginResource"] == null) {
        return response["message"];
      }

      this.email = email;

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
      updateUser(User.fromJson(res));
      return user;
    } catch (e) {
      print('AuthService.getUserDetails e: $e');
      return null;
    }
  }

  Future<bool> changePassword(
      {String currentPassword, String newPassword}) async {
    try {
      final res = await _httpService.post(
          path: "user/changePass",
          body: {"currentPass": currentPassword, "newPass": newPassword});

      print('AuthService.changePassword res: $res');
      if (res == null) {
        return false;
      }
      return true;
    } catch (e) {
      print('AuthService.changePassword e: $e');
      return false;
    }
  }

  Future<bool> updateUserDetails({String name, String phone}) async {
    try {
      final res = await _httpService.put(path: "user/me", body: {
        'fullname': name,
        'phone': phone,
      });
      if (res == null) {
        return false;
      }
      updateUser(user.copyWith(name: name, phone: phone));
      return true;
    } catch (e) {
      print('AuthService.updateUserDetails e: $e');
      return false;
    }
  }

  Future<dynamic> sendVerificationCode({String email, String token}) async {
    try {
      final res = await _httpService
          .post(path: "auth/verify", body: {"email": email, "token": token});

      print('AuthService.sendVerificationCode res: $res');

      if (res == null || res["successfull"] == null) {
        return false;
      }

      final success = res["successfull"];

      if (success == false) {
        return res["message"];
      }

      return true;
    } catch (e) {
      print('AuthService.sendVerificationCode e: $e');
      return false;
    }
  }

  void logout() {
    _httpService.setToken(null);
  }
}
