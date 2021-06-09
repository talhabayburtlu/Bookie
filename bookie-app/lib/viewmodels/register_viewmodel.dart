import 'package:bookie/app/locator.dart';
import 'package:bookie/app/router.gr.dart';
import 'package:bookie/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> register(
      {String fullName,
      int age,
      String phone,
      String email,
      String password}) async {
    setBusy(true);

    final result = await _authService.register(
        fullName: fullName,
        phone: phone,
        email: email,
        password: password,
        age: age);

    print('RegisterViewModel.register result is $result');
    if (!result) {
      _snackbarService.showSnackbar(message: "Something went wrong!");
      setBusy(false);

      return;
    }
    _snackbarService.showSnackbar(message: "Successful!");
    _navigationService.clearStackAndShow(Routes.homeView);
    setBusy(false);
  }
}
