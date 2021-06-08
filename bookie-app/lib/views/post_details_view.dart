import 'package:bookie/models/book.dart';
import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/post_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

class PostDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostDetailsViewModel>.reactive(
      viewModelBuilder: () => PostDetailsViewModel(),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: SpeedDial(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.call,
            color: Colors.white,
          ),
          children: [
            SpeedDialChild(
              child: Icon(FontAwesomeIcons.whatsapp),
              backgroundColor: Colors.green,
              label: 'Whatsapp',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => model.launchWhatsapp(),
            ),
            SpeedDialChild(
              child: Icon(Icons.message),
              backgroundColor: Colors.yellow,
              label: 'SMS',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => model.launchSms(),
            ),
            SpeedDialChild(
                child: Icon(Icons.call),
                backgroundColor: Colors.blue,
                label: 'Call',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => model.launchCall()),
          ],
        ),
        appBar: AppBar(
          title: Text("Post Details"),
        ),
        body: SingleChildScrollView(
          child: Container(
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
                    .map((Book book) => Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                          child: InkWell(
                            onTap: () {
                              model.showBookDetails(book);
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Image.network(
                                    book.imageThumbnailLink ??
                                        BOOK_FALLBACK_URL,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  horizontalSpaceSmall,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book.title,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      if (book.author != null)
                                        Text(
                                          "Author:  ${book.author}",
                                          textAlign: TextAlign.start,
                                        )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
