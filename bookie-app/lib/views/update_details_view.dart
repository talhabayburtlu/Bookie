import 'package:bookie/viewmodels/update_details_viewmodel.dart';
import 'package:bookie/widgets/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UpdateDetailsView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateDetailsViewModel>.reactive(
        viewModelBuilder: () => UpdateDetailsViewModel(),
        builder: (context, model, _) => Scaffold(
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.save),
                onPressed: model.isBusy
                    ? null
                    : () async {
                        if (_formKey.currentState.validate() == false) {
                          return;
                        }
                        await model.validateInputsAndUpdate(
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text);
                      },
              ),
              appBar: GlobalAppBar(
                title: "Update Profile",
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
                                Text("Name: "),
                                Expanded(
                                  child: TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Name can not be empty";
                                      }
                                      return null;
                                    },
                                    controller: _nameController
                                      ..text = model.user.name,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Email: "),
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Email can not be empty";
                                      }
                                      return null;
                                    },
                                    controller: _emailController
                                      ..text = model.user.email,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Phone: "),
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Phone not be empty";
                                      }
                                      return null;
                                    },
                                    controller: _phoneController
                                      ..text = model.user.phone,
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
