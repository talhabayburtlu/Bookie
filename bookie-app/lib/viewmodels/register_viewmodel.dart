import 'package:bookie/app/locator.dart';
import 'package:bookie/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class RegisterViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();

  Future<void> register(String email, String password) async {
    setBusy(true);
    await _authService.register();
    setBusy(false);
  }
}
