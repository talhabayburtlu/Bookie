import 'package:bookie/app/locator.dart';
import 'package:bookie/models/user.dart';
import 'package:bookie/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UpdateDetailsViewModel extends FutureViewModel<User> {
  final _authService = locator<AuthService>();
  final _snackbarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();

  User _user;

  User get user => _user;

  @override
  Future<User> futureToRun() async {
    _user = await _authService.getUserDetails();
    return _user;
  }

  Future<void> validateInputsAndUpdate({String name, String phone}) async {
    if (name.isEmpty || phone.isEmpty) {
      return;
    }
    setBusy(true);

    final success =
        await _authService.updateUserDetails(name: name, phone: phone);
    if (success) {
      _navigationService.back();
      _snackbarService.showSnackbar(message: "Successful !");
    } else {
      _snackbarService.showSnackbar(message: "Something went wrong !");
    }
    setBusy(false);
  }
}
