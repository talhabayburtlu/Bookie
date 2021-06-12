import 'package:bubble/bubble.dart';
import 'package:bookie/models/comment.dart';
import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/book_details_viewmodel.dart';
import 'package:bookie/widgets/global_appbar.dart';
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
          onPressed: () {
            model.addComment(context);
          },
        ),
        appBar: GlobalAppBar(
          title: "Book Details",
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return model.refresh();
          },
          child: Container(
            padding: EdgeInsets.all(4),
            width: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Image.network(
                    model.selectedBook.imageThumbnailLink ?? BOOK_FALLBACK_URL,
                    width: 160,
                  ),
                  verticalSpaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Title: ",
                        style: TextStyle(
                            fontSize: FONT_SIZE_MEDIUM,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${model.selectedBook.title}",
                        style: TextStyle(
                          fontSize: FONT_SIZE_MEDIUM,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Author: ",
                          style: TextStyle(
                              fontSize: FONT_SIZE_MEDIUM,
                              fontWeight: FontWeight.bold)),
                      Text("${model.selectedBook.author}",
                          style: TextStyle(
                            fontSize: FONT_SIZE_MEDIUM,
                          ))
                    ],
                  ),
                  if (model.selectedBook.subtitle != null)
                    Row(
                      children: [
                        Text(
                          "Subtitle: ",
                          style: TextStyle(fontSize: FONT_SIZE_MEDIUM),
                        ),
                        Text(
                          "${model.selectedBook.subtitle}",
                          style: TextStyle(fontSize: FONT_SIZE_MEDIUM),
                        )
                      ],
                    ),
                  verticalSpaceMedium,
                  if (model.comments.isNotEmpty)
                    Container(
                      padding: EdgeInsets.only(left: 4, bottom: 2),
                      child: Align(
                        child: Text(
                          "Comments:",
                          style: TextStyle(
                              fontSize: FONT_SIZE_MEDIUM,
                              fontWeight: FontWeight.w500),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) => CommentWidget(
                            comment: model.comments[i],
                          ),
                      separatorBuilder: (_, __) => Divider(),
                      itemCount: model.comments.length)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                comment.senderName,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                comment.formattedDate,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              )
            ],
          ),
          verticalSpaceSmall,
          Text(
            comment.description,
            style: TextStyle(color: Colors.black, fontSize: 16),
          )
        ],
      ),
    );
  }
}
