import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/register_viewmodel.dart';
import 'package:bookie/widgets/busy_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, model, _) => Scaffold(
          appBar: AppBar(
            title: Text("Register"),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  verticalSpaceMedium,
                  Container(
                    height: SizeConfig.blockSizeVertical * 40,
                    width: SizeConfig.blockSizeHorizontal * 80,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Eposta"),
                            controller: _emailController,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter an email";
                              }
                              if (val.contains('@') == false ||
                                  val.length < 5) {
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Şifre"),
                            controller: _passwordController,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter a password";
                              }
                              if (val.length < 3) {
                                return "Please enter a valid password (at least 4 characters)";
                              }
                              return null;
                            },
                          ),
                          verticalSpaceSmall,
                          BusyButton(
                            busy: model.isBusy,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await model.register(_emailController.text,
                                    _passwordController.text);
                              }
                            },
                            title: Text("Register"),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22)),
                                color: const Color(0xff677fff)),
                          ),
                          verticalSpaceMedium,
                        ],
                      ),
                    ),
                  ),
                  verticalSpaceMedium,
                ],
              ),
            ),
          )),
    );
  }
}
