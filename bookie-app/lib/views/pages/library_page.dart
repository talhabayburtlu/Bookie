import 'package:bookie/models/book.dart';
import 'package:bookie/utils/ui_helpers.dart';
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
            : model.books.isEmpty
                ? Center(
                    child: Text(
                      "Your Library is Empty!",
                      style: TextStyle(fontSize: 26),
                    ),
                  )
                : ListView.separated(
                    itemCount: model.books.length,
                    separatorBuilder: (_, __) => Divider(
                      color: Colors.grey,
                    ),
                    itemBuilder: (ctx, i) => BookWidget(book: model.books[i]),
                  ));
  }
}

class BookWidget extends ViewModelWidget<LibraryPageViewModel> {
  final Book book;

  const BookWidget({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context, LibraryPageViewModel model) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          Image.network(
            book.imageThumbnailLink ?? BOOK_FALLBACK_URL,
            fit: BoxFit.cover,
            width: 70,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    book.title ?? "TITLE",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  if (book.author != null)
                    Text("by ${book.author}" ?? "AUTHOR"),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              model.removeFromLibrary(book);
            },
            icon: Icon(
              Icons.delete,
              color: red,
            ),
          )
        ],
      ),
    );
  }
}
