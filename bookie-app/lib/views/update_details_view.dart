import 'package:bookie/viewmodels/update_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UpdateDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateDetailsViewModel>.reactive(
        viewModelBuilder: () => UpdateDetailsViewModel(),
        builder: (context, model, _) => Scaffold(
              appBar: AppBar(
                title: Text("Update Profile"),
              ),
              body: Column(),
            ));
  }
}
