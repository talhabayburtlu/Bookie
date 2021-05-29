import 'package:bookie/models/book.dart';
import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/post_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PostDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostDetailsViewModel>.reactive(
      viewModelBuilder: () => PostDetailsViewModel(),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.call),
          onPressed: () {},
        ),
        appBar: AppBar(
          title: Text("Post Details"),
        ),
        body: Container(
          padding: EdgeInsets.all(4),
          child: Column(
            children: [
              verticalSpaceSmall,
              Text(
                "Kullanıcı: ${model.user.name}",
                style: TextStyle(fontSize: 20),
              ),
              verticalSpaceSmall,
              Divider(
                color: Colors.grey,
              ),
              verticalSpaceSmall,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Kitaplar: ",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              verticalSpaceSmall,
              ...model.selectedPost.books
                  .map((Book book) => InkWell(
                        onTap: () {
                          model.showBookDetails(book);
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Image.network(
                                book.imageThumbnailLink,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                              horizontalSpaceSmall,
                              Column(
                                children: [
                                  Text(
                                    book.title,
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  if (book.author != null)
                                    Text("Author:  ${book.author}")
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
