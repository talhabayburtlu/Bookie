import 'package:bookie/models/book.dart';
import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/add_library_viewmodel.dart';
import 'package:bookie/widgets/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddLibraryView extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddLibraryViewModel>.reactive(
      viewModelBuilder: () => AddLibraryViewModel(),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: model.showFAB
            ? FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  model.saveBooks();
                },
                child: Icon(Icons.save),
              )
            : null,
        appBar: GlobalAppBar(
          title: "Add Books",
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "Search"),
                      controller: _searchController,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final query = _searchController.text;
                      if (query.isEmpty) {
                        return;
                      }
                      await model.searchBooks(query);
                    },
                    icon: Icon(Icons.search),
                  )
                ],
              ),
            ),
            model.isBusy
                ? CircularProgressIndicator()
                : Container(
                    child: Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: model.searchResults.length,
                        itemBuilder: (ctx, i) => BookWidget(
                          book: model.searchResults[i],
                        ),
                        separatorBuilder: (_, __) => Divider(),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class BookWidget extends ViewModelWidget<AddLibraryViewModel> {
  final Book book;

  const BookWidget({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context, AddLibraryViewModel model) {
    return InkWell(
      onTap: () {
        model.selectBook(book);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          children: [
            Image.network(
              book.imageSmallThumbnailLink ?? BOOK_FALLBACK_URL,
              fit: BoxFit.cover,
              width: 50,
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
                          color: model.isSelected(book)
                              ? Colors.green
                              : Colors.black),
                    ),
                    verticalSpaceSmall,
                    Text("by ${book.author}" ?? "AUTHOR"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
