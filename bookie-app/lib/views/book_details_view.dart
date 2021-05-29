import 'dart:ffi';

import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/book_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BookDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookDetailsViewModel>.reactive(
      viewModelBuilder: () => BookDetailsViewModel(),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: () {},
        ),
        appBar: AppBar(
          title: Text("Book Details"),
        ),
        body: Container(
          padding: EdgeInsets.all(4),
          width: double.infinity,
          child: Column(
            children: [
              Image.network(
                  model.selectedBook.imageThumbnailLink ?? BOOK_FALLBACK_URL),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Title: "),
                  Text("${model.selectedBook.title}"),
                ],
              ),
              Text("Author: ${model.selectedBook.author}"),
              Text("Subtitle: ${model.selectedBook.subtitle}")
            ],
          ),
        ),
      ),
    );
  }
}
