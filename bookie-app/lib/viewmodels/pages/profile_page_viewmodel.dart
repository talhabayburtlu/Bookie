import 'package:bookie/app/locator.dart';
import 'package:bookie/app/router.gr.dart';
import 'package:bookie/models/post.dart';
import 'package:bookie/models/user.dart';
import 'package:bookie/services/auth_service.dart';
import 'package:bookie/services/post_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfilePageViewModel extends FutureViewModel<User> {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  User _user;

  User get user => _user;

  void logout() {
    _authService.logout();
    _navigationService.clearStackAndShow(Routes.loginView);
  }

  @override
  Future<User> futureToRun() async {
    _user = await _authService.getUserDetails();
    return _user;
  }

  void updateProfile() {
    _navigationService.navigateTo(Routes.updateDetailsView);
  }
}
