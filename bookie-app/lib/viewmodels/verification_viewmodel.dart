import 'package:bookie/app/locator.dart';
import 'package:bookie/app/router.gr.dart';
import 'package:bookie/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VerificationViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();

  int requiredLength = 6;
  int enteredCodeLength = 0;
  String code = "";

  bool get isCodeShort => enteredCodeLength < requiredLength;

  String get registerEmail => _authService.email;

  void onUpdate(String value) {
    enteredCodeLength = value.length;
    code = value;
    notifyListeners();
  }

  Future<void> verify(String email) async {
    if (code.length != requiredLength) {
      _snackbarService.showSnackbar(message: "Your code is too short!");
      return;
    }
    setBusy(true);
    final result =
        await _authService.sendVerificationCode(token: code, email: email);

    if (result is String || result == false) {
      _snackbarService.showSnackbar(message: result);
    } else {
      _navigationService.clearStackAndShow(Routes.loginView);
      _snackbarService.showSnackbar(
          message: "Verification has been completed! You can Login ");
    }
    setBusy(false);
  }
}
