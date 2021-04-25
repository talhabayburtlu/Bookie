import 'package:bookie/models/book.dart';
import 'package:bookie/models/post.dart';
import 'package:bookie/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Text(post.user.name),
            verticalSpaceSmall,
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: post.books
                    .map(
                      (Book book) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Image.network(
                            book.imageThumbnailLink,
                            fit: BoxFit.cover,
                            height: 60,
                          )),
                    )
                    .toList(),
              ),
            ),
            verticalSpaceSmall,
          ],
        ),
      ),
    );
  }
}
