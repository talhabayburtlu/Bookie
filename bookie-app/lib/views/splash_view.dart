import 'package:bookie/widgets/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
        builder: (context, model, child) {
          SizeConfig().init(context);
          return Scaffold(
            appBar: GlobalAppBar(
              title: "Bookie",
            ),
            body: Center(
              child: model.isBusy ? CircularProgressIndicator() : Container(),
            ),
          );
        },
        viewModelBuilder: () => SplashViewModel());
  }
}
