import 'package:bookie/app/locator.dart';
import 'package:bookie/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends FutureViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  Future waitAndGoHome() async {
    await Future.delayed(Duration(seconds: 2));
    _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
  }

  @override
  Future futureToRun() => waitAndGoHome();
}
