import 'package:bookie/models/book.dart';
import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/post_details_viewmodel.dart';
import 'package:bookie/widgets/global_appbar.dart';
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
        appBar: GlobalAppBar(
          title: "Post Details",
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Kullanıcı: ",
                      style: TextStyle(
                          fontSize: FONT_SIZE_MEDIUM,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${model.user.name}",
                      style: TextStyle(fontSize: FONT_SIZE_MEDIUM),
                    )
                  ],
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
                    style: TextStyle(
                        fontSize: FONT_SIZE_LARGE, fontWeight: FontWeight.w500),
                  ),
                ),
                verticalSpaceSmall,
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) {
                      final book = model.selectedPost.books[i];
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                        child: InkWell(
                          onTap: () {
                            model.showBookDetails(book);
                          },
                          child: Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Image.network(
                                    book.imageThumbnailLink ??
                                        BOOK_FALLBACK_URL,
                                    width: 70,
                                    height: 90,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  horizontalSpaceSmall,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book.title,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: FONT_SIZE_LARGE,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      if (book.author != null)
                                        Text(
                                          "Author:  ${book.author}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300),
                                          textAlign: TextAlign.start,
                                        )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => Divider(
                          color: Colors.grey,
                        ),
                    itemCount: model.selectedPost.books.length)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
