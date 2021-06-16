import 'package:bookie/app/locator.dart';
import 'package:bookie/app/router.gr.dart';
import 'package:bookie/models/city.dart';
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
      String password,
      City city}) async {
    setBusy(true);

    final result = await _authService.register(
        fullName: fullName,
        phone: phone,
        email: email,
        password: password,
        age: age,
        addressId: city.id);

    print('RegisterViewModel.register result is $result');
    if (result is String || result == false) {
      _snackbarService.showSnackbar(message: result);
      setBusy(false);
      return;
    }
    _snackbarService.showSnackbar(
        message: "Successful! You need to verify your email");
    _navigationService.navigateTo(Routes.verificationView);
    setBusy(false);
  }
}
