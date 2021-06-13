import 'package:bookie/app/locator.dart';
import 'package:bookie/app/router.gr.dart';
import 'package:bookie/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  Future<bool> login(String email, String password) async {
    setBusy(true);
    final result = await _authService.login(email: email, password: password);
    setBusy(false);
    if (result is String || result == false) {
      _snackbarService.showSnackbar(message: result);
    } else {
      _navigationService.clearStackAndShow(Routes.homeView);
    }

    return true;
  }

  void register() {
    _navigationService.navigateTo(Routes.registerView);
  }
}
