import 'package:bookie/app/locator.dart';
import 'package:bookie/models/user.dart';
import 'package:bookie/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class UpdateDetailsViewModel extends FutureViewModel<User> {
  final _authService = locator<AuthService>();

  User _user;
  User get user => _user;

  @override
  Future<User> futureToRun() async {
    _user = await _authService.getUserDetails();
    return _user;
  }

  Future<void> validateInputsAndUpdate(
      {String name, String email, String phone}) async {}
}
