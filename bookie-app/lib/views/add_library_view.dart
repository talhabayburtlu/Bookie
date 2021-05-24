import 'package:bookie/models/book.dart';
import 'package:bookie/viewmodels/add_library_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddLibraryView extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddLibraryViewModel>.reactive(
      viewModelBuilder: () => AddLibraryViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Add Books"),
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
            book.imageSmallThumbnailLink ??
                "https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Book.svg/875px-Book.svg.png",
            fit: BoxFit.cover,
            width: 50,
          ),
          Container(
            child: Column(
              children: [
                Text(book.title ?? "TITLE"),
                Text(book.author ?? "AUTHOR")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
