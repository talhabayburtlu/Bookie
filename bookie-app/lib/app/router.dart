import 'package:auto_route/auto_route_annotations.dart';
import 'package:bookie/views/add_library_view.dart';
import 'package:bookie/views/book_details_view.dart';
import 'package:bookie/views/change_password_view.dart';
import 'package:bookie/views/home_view.dart';
import 'package:bookie/views/login_view.dart';
import 'package:bookie/views/post_details_view.dart';
import 'package:bookie/views/register_view.dart';
import 'package:bookie/views/splash_view.dart';
import 'package:bookie/views/update_details_view.dart';
import 'package:bookie/views/verification_view.dart';

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
  MaterialRoute(
    page: UpdateDetailsView,
  ),
  MaterialRoute(
    page: PostDetailsView,
  ),
  MaterialRoute(
    page: BookDetailsView,
  ),
  MaterialRoute(
    page: ChangePasswordView,
  ),
  MaterialRoute(
    page: VerificationView,
  ),
])
class $Router {}
