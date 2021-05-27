import 'package:bookie/viewmodels/pages/profile_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfilePageViewModel>.reactive(
      builder: (ctx, model, _) => model.isBusy
          ? CircularProgressIndicator()
          : Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    child: Card(
                      child: Column(
                        children: [
                          Text("${model.user.name}"),
                          Text("${model.user.email}"),
                          Text("${model.user.phone}")
                        ],
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      model.updateProfile();
                    },
                    child: Text("Update Profile"),
                  ),
                  RaisedButton(
                    child: Text("Log out"),
                    onPressed: () {
                      model.logout();
                    },
                  ),
                ],
              ),
            ),
      viewModelBuilder: () => ProfilePageViewModel(),
    );
  }
}
