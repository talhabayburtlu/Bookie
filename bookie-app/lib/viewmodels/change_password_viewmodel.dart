import 'package:bookie/app/locator.dart';
import 'package:bookie/services/auth_service.dart';
import 'package:bookie/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChangePasswordViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();

  Future<void> changePassword(
      {String currentPassword, String newPassword}) async {
    setBusy(true);
    final res = await _authService.changePassword(
        currentPassword: currentPassword, newPassword: newPassword);
    if (res == false) {
      _snackbarService.showSnackbar(message: "Something went wrong!");
    } else {
      _navigationService.back();
    }
    setBusy(false);
  }
}
