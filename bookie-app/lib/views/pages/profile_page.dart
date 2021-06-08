import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/pages/profile_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfilePageViewModel>.reactive(
      builder: (ctx, model, _) => model.isBusy
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: double.infinity,
              child: Column(
                children: [
                  verticalSpaceMedium,
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Name: "),
                            Text("${model.user.name}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Email: "),
                            Text("${model.user.email}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Phone: "),
                            Text("${model.user.phone}"),
                          ],
                        )
                      ],
                    ),
                  ),
                  verticalSpaceMedium,
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
