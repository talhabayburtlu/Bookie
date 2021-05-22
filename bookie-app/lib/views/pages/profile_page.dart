import 'package:bookie/viewmodels/pages/profile_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfilePageViewModel>.reactive(
      builder: (ctx, model, _) => Column(
        children: [
          Container(
            child: Text("profile"),
          ),
          RaisedButton(
            child: Text("Log out"),
            onPressed: () {
              model.logout();
            },
          ),
        ],
      ),
      viewModelBuilder: () => ProfilePageViewModel(),
    );
  }
}
