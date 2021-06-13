import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/change_password_viewmodel.dart';
import 'package:bookie/widgets/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChangePasswordView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _newAgainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
        viewModelBuilder: () => ChangePasswordViewModel(),
        builder: (context, model, _) => Scaffold(
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.save),
                onPressed: model.isBusy
                    ? null
                    : () async {
                        if (_formKey.currentState.validate() == false) {
                          return;
                        }
                      },
              ),
              appBar: GlobalAppBar(
                title: "Change Password",
              ),
              body: model.isBusy
                  ? CircularProgressIndicator()
                  : Container(
                      padding: EdgeInsets.all(8),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Current Password: ",
                                  style: TextStyle(
                                      fontSize: FONT_SIZE_MEDIUM,
                                      fontWeight: FontWeight.w500),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: _currentController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Password can not be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "New Password: ",
                                  style: TextStyle(
                                      fontSize: FONT_SIZE_MEDIUM,
                                      fontWeight: FontWeight.w500),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: _newController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Password can not be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Verify New Password: ",
                                  style: TextStyle(
                                      fontSize: FONT_SIZE_MEDIUM,
                                      fontWeight: FontWeight.w500),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: _newAgainController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Password can not be empty";
                                      }
                                      final newPassword = _newController.text;
                                      if (newPassword != val) {
                                        return "Passwords do not match!";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
            ));
  }
}
