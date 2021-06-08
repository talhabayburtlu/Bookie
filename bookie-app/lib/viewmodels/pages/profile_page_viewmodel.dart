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

  List<ReactiveServiceMixin> _reactiveServices = [];

  User get user => _authService.user;

  ProfilePageViewModel() {
    _reactiveServices = [_authService];
    _reactToServices(_reactiveServices);
  }

  void _reactToServices(List<ReactiveServiceMixin> reactiveServices) {
    _reactiveServices = reactiveServices;
    for (var reactiveService in _reactiveServices) {
      reactiveService.addListener(_indicateChange);
    }
  }

  @override
  void dispose() {
    for (var reactiveService in _reactiveServices) {
      reactiveService.removeListener(_indicateChange);
    }
    super.dispose();
  }

  void _indicateChange() {
    notifyListeners();
  }

  void logout() {
    _authService.logout();
    _navigationService.clearStackAndShow(Routes.loginView);
  }

  @override
  Future<User> futureToRun() async {
    final user = await _authService.getUserDetails();
    _authService.updateUser(user);
    return user;
  }

  void updateProfile() {
    _navigationService.navigateTo(Routes.updateDetailsView);
  }
}
