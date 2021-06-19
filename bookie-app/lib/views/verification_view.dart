import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/verification_viewmodel.dart';
import 'package:bookie/widgets/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

class VerificationView extends StatelessWidget {
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerificationViewModel>.reactive(
      viewModelBuilder: () => VerificationViewModel(),
      onModelReady: (model) {
        if (model.registerEmail != null) {
          _emailController.text = model.registerEmail;
        }
      },
      builder: (context, model, child) => Scaffold(
        appBar: GlobalAppBar(
          title: "Verification Page",
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              height: SizeConfig.screenHeight,
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  verticalSpaceMedium,
                  Text(
                    "Please enter the verification code we sent to your email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: FONT_SIZE_MEDIUM,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  verticalSpaceMedium,
                  Text("Enter your email: ",
                      style: TextStyle(
                          fontSize: FONT_SIZE_LARGE,
                          fontWeight: FontWeight.w500)),
                  verticalSpaceSmall,
                  Container(
                    width: SizeConfig.screenWidth / 2,
                    child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Email can't be empty";
                        }
                        if (val.contains("@") == false) {
                          return "Email is not valid";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      expands: false,
                      controller: _emailController,
                    ),
                  ),
                  verticalSpaceMedium,
                  Text(
                    "Enter your verification code: ",
                    style: TextStyle(
                        fontSize: FONT_SIZE_LARGE, fontWeight: FontWeight.w500),
                  ),
                  verticalSpaceMedium,
                  Container(
                      child: PinCodeTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Verification code is empty!";
                      }
                      if (val.length < model.requiredLength) {
                        return "Verification code is too short";
                      }
                      return null;
                    },
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    animationDuration: Duration(milliseconds: 300),
                    keyboardType: TextInputType.text,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        activeColor: blue,
                        inactiveColor: Colors.grey,
                        selectedColor: Theme.of(context).primaryColor),
                    backgroundColor: Colors.transparent,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: FONT_SIZE_LARGE,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    enableActiveFill: false,
                    onCompleted: (value) {},
                    onChanged: (String value) {
                      model.onUpdate(value);
                    },
                  )),
                  verticalSpaceMedium,
                  verticalSpaceMedium,
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        "Verify",
                        style: TextStyle(
                            color: Colors.white, fontSize: FONT_SIZE_LARGE),
                      ),
                      color: Colors.green,
                      onPressed: model.isBusy
                          ? null
                          : () async {
                              if (_formKey.currentState.validate() == false) {
                                return;
                              }
                              await model.verify(_emailController.text);
                            },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
