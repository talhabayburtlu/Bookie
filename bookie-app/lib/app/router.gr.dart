// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../views/add_library_view.dart';
import '../views/book_details_view.dart';
import '../views/change_password_view.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/post_details_view.dart';
import '../views/register_view.dart';
import '../views/splash_view.dart';
import '../views/update_details_view.dart';

class Routes {
  static const String splashView = '/';
  static const String homeView = '/home-view';
  static const String loginView = '/login-view';
  static const String registerView = '/register-view';
  static const String addLibraryView = '/add-library-view';
  static const String updateDetailsView = '/update-details-view';
  static const String postDetailsView = '/post-details-view';
  static const String bookDetailsView = '/book-details-view';
  static const String changePasswordView = '/change-password-view';
  static const all = <String>{
    splashView,
    homeView,
    loginView,
    registerView,
    addLibraryView,
    updateDetailsView,
    postDetailsView,
    bookDetailsView,
    changePasswordView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.addLibraryView, page: AddLibraryView),
    RouteDef(Routes.updateDetailsView, page: UpdateDetailsView),
    RouteDef(Routes.postDetailsView, page: PostDetailsView),
    RouteDef(Routes.bookDetailsView, page: BookDetailsView),
    RouteDef(Routes.changePasswordView, page: ChangePasswordView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    RegisterView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterView(),
        settings: data,
      );
    },
    AddLibraryView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddLibraryView(),
        settings: data,
      );
    },
    UpdateDetailsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UpdateDetailsView(),
        settings: data,
      );
    },
    PostDetailsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PostDetailsView(),
        settings: data,
      );
    },
    BookDetailsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => BookDetailsView(),
        settings: data,
      );
    },
    ChangePasswordView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChangePasswordView(),
        settings: data,
      );
    },
  };
}
