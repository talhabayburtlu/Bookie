import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/register_viewmodel.dart';
import 'package:bookie/widgets/busy_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  int _ageValue;

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
                                labelText: "Full Name"),
                            controller: _nameController,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter your full name";
                              }
                              return null;
                            },
                          ),
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
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Phone Number"),
                            controller: _phoneController,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter your phone number";
                              }
                              return null;
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: DropdownButtonFormField<int>(
                                validator: (age) {
                                  if (age == null) {
                                    return "Please select your age";
                                  }
                                  if (age < 1 || age > 100) {
                                    return "Please select a valid age";
                                  }
                                  return null;
                                },
                                hint: Text("Select Your Age"),
                                isExpanded: true,
                                items: List.generate(
                                  90,
                                  (index) => DropdownMenuItem<int>(
                                    value: index + 1,
                                    child: Container(
                                      width: 100,
                                      child: Text("${index + 1}"),
                                    ),
                                  ),
                                ),
                                onChanged: (newAge) {
                                  setState(() {
                                    this._ageValue = newAge;
                                  });
                                },
                                value: _ageValue,
                              ),
                            ),
                          ),
                          verticalSpaceSmall,
                          BusyButton(
                            busy: model.isBusy,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await model.register(
                                    age: _ageValue,
                                    password: _passwordController.text,
                                    email: _emailController.text,
                                    fullName: _nameController.text,
                                    phone: _phoneController.text);
                              }
                            },
                            title: Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
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
