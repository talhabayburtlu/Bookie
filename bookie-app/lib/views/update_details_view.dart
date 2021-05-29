import 'package:bookie/viewmodels/update_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UpdateDetailsView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateDetailsViewModel>.reactive(
        viewModelBuilder: () => UpdateDetailsViewModel(),
        builder: (context, model, _) => Scaffold(
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.save),
                onPressed: () {
                  model.validateInputsAndUpdate(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text);
                },
              ),
              appBar: AppBar(
                title: Text("Update Profile"),
              ),
              body: model.isBusy
                  ? CircularProgressIndicator()
                  : Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Name: "),
                              Expanded(
                                child: TextField(
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
                                child: TextField(
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
                                child: TextField(
                                  controller: _phoneController
                                    ..text = model.user.phone,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ));
  }
}
