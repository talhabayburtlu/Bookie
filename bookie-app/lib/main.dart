import 'package:flutter/material.dart';
import 'package:bookie/constants/strings.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';
import 'app/router.gr.dart' as r;

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.APP_NAME,
      debugShowCheckedModeBanner: false,
      initialRoute: r.Routes.splashView,
      onGenerateRoute: r.Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
