import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/login_viewmodel.dart';
import 'package:bookie/widgets/busy_button.dart';
import 'package:bookie/widgets/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, _) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: GlobalAppBar(
          title: "Login",
        ),
        body: SingleChildScrollView(
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: Column(
              children: [
                verticalSpaceMedium,
                Container(
                  height: SizeConfig.blockSizeVertical * 50,
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
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter an email";
                            }
                            if (val.contains('@') == false || val.length < 5) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        verticalSpaceSmall,
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Şifre"),
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
                              await model.login(_emailController.text,
                                  _passwordController.text);
                            }
                          },
                          title: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22)),
                              color: const Color(0xff677fff)),
                        ),
                        verticalSpaceMedium,
                        FlatButton(
                          child: Text.rich(
                            TextSpan(text: "New here? ", children: [
                              TextSpan(
                                  text: "Register!",
                                  style: TextStyle(color: Colors.amber[800])),
                            ]),
                          ),
                          onPressed: () {
                            model.register();
                          },
                        ),
                        verticalSpaceSmall,
                        FlatButton(
                          child: Text(
                            "Enter your verification token!",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () {
                            model.verificationPage();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpaceMedium,
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
