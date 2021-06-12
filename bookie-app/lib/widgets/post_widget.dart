import 'package:bookie/models/book.dart';
import 'package:bookie/models/post.dart';
import 'package:bookie/utils/ui_helpers.dart';
import 'package:bookie/viewmodels/pages/home_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PostWidget extends ViewModelWidget<HomePageViewModel> {
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context, HomePageViewModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: InkWell(
        onTap: () {
          model.showPostDetails(post);
        },
        child: Container(
          padding: EdgeInsets.only(),
          margin: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(9)),
            border: Border.all(color: const Color(0x59abb4bd), width: 0.5),
          ),
          child: Column(
            children: [
              verticalSpaceSmall,
              Text(
                post.user?.name ?? "",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                post.user?.phone ?? "",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
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
                              book.imageThumbnailLink ?? BOOK_FALLBACK_URL,
                              fit: BoxFit.scaleDown,
                              width: 80,
                            )),
                      )
                      .toList(),
                ),
              ),
              verticalSpaceSmall,
            ],
          ),
        ),
      ),
    );
  }
}
