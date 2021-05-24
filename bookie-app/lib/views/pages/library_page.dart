import 'package:bookie/models/book.dart';
import 'package:bookie/viewmodels/pages/library_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LibraryPageViewModel>.reactive(
      viewModelBuilder: () => LibraryPageViewModel(),
      builder: (ctx, model, _) => model.isBusy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: model.books
                  .map((book) => BookWidget(
                        book: book,
                      ))
                  .toList(),
            ),
    );
  }
}

class BookWidget extends StatelessWidget {
  final Book book;

  const BookWidget({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          Image.network(
            book.imageThumbnailLink,
            fit: BoxFit.cover,
            width: 100,
          ),
          Container(
            child: Column(
              children: [Text(book.title), Text(book.author)],
            ),
          ),
        ],
      ),
    );
  }
}
