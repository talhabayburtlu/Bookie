import 'package:auto_route/auto_route_annotations.dart';
import 'package:bookie/views/add_library_view.dart';
import 'package:bookie/views/home_view.dart';
import 'package:bookie/views/login_view.dart';
import 'package:bookie/views/register_view.dart';
import 'package:bookie/views/splash_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(
    page: SplashView,
    initial: true,
  ),
  MaterialRoute(
    page: HomeView,
  ),
  MaterialRoute(
    page: LoginView,
  ),
  MaterialRoute(
    page: RegisterView,
  ),
  MaterialRoute(
    page: AddLibraryView,
  ),
])
class $Router {}
