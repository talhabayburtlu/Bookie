import 'package:bookie/models/city.dart';
import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/register_viewmodel.dart';
import 'package:bookie/widgets/busy_button.dart';
import 'package:bookie/widgets/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  City _selectedCity;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, model, _) => Scaffold(
          appBar: GlobalAppBar(
            title: "Register",
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
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email"),
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
                                labelText: "Password"),
                            controller: _passwordController,
                            obscureText: true,
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
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(11)
                            ],
                            decoration: InputDecoration(
                                hintText: "0XXXXXXXXXX",
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
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: DropdownButtonFormField<City>(
                                validator: (city) {
                                  if (city == null) {
                                    return "Please select your city";
                                  }
                                  return null;
                                },
                                hint: Text("Select Your City"),
                                isExpanded: true,
                                items: cities
                                    .map((City city) => DropdownMenuItem<City>(
                                          child: Text(city.name),
                                          value: city,
                                        ))
                                    .toList(),
                                onChanged: (city) {
                                  setState(() {
                                    _selectedCity = city;
                                  });
                                },
                                value: _selectedCity,
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
                                    phone: _phoneController.text,
                                    city: _selectedCity);
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
