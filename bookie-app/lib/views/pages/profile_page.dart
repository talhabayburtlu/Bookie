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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Name: ",
                              style: TextStyle(
                                  fontSize: FONT_SIZE_MEDIUM,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${model.user.name}",
                              style: TextStyle(fontSize: FONT_SIZE_MEDIUM),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Email: ",
                              style: TextStyle(
                                  fontSize: FONT_SIZE_MEDIUM,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${model.user.email}",
                              style: TextStyle(fontSize: FONT_SIZE_MEDIUM),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Phone: ",
                              style: TextStyle(
                                  fontSize: FONT_SIZE_MEDIUM,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${model.user.phone}",
                              style: TextStyle(fontSize: FONT_SIZE_MEDIUM),
                            ),
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
                    onPressed: () {
                      model.changePassword();
                    },
                    child: Text("Change Password"),
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
