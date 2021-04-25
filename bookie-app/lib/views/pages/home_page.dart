import 'package:bookie/models/post.dart';
import 'package:bookie/viewmodels/pages/home_page_viewmodel.dart';
import 'package:bookie/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      viewModelBuilder: () => HomePageViewModel(),
      builder: (context, model, _) => Container(
        child: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: model.data
                    .map((Post post) => PostWidget(post: post))
                    .toList()),
      ),
    );
  }
}
