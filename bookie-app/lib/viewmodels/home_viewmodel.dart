import 'package:bookie/app/locator.dart';
import 'package:bookie/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends IndexTrackingViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  bool get shouldShowFAB {
    return currentIndex == 1;
  }

  void navigateToAddView() {
    _navigationService.navigateTo(Routes.addLibraryView);
  }

  goToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }
}
