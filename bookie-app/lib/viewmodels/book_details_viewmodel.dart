import 'package:bookie/app/locator.dart';
import 'package:bookie/models/book.dart';
import 'package:bookie/models/comment.dart';
import 'package:bookie/services/auth_service.dart';
import 'package:bookie/services/post_service.dart';
import 'package:bookie/utils/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BookDetailsViewModel extends FutureViewModel<List<dynamic>> {
  final _postService = locator<PostService>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  List<Comment> comments = [];

  Book get selectedBook => _postService.selectedBook;

  @override
  Future<List<Comment>> futureToRun() async {
    comments = await _postService.fetchCommentsForPost();
    return comments;
  }

  void addComment(BuildContext context) async {
    final _commentController = TextEditingController();
    bool _loading = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
          builder: (ctx, setState) => AlertDialog(
                title: Text("Add Comment"),
                actions: [
                  FlatButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => _navigationService.back(),
                  ),
                  RaisedButton(
                    onPressed: _loading
                        ? null
                        : () async {
                            if (_commentController.text.isEmpty) {
                              return;
                            }
                            setState(() {
                              _loading = true;
                            });
                            final res = await _postService
                                .addComment(_commentController.text);
                            if (res) {
                              _navigationService.back();
                              _snackbarService.showSnackbar(
                                  message: "Your comment has been added");
                            } else {
                              print('BookDetailsViewModel.addComment else');
                            }
                            setState(() {
                              _loading = false;
                            });
                          },
                    child: Text("Send"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  )
                ],
                content: Container(
                  height: SizeConfig.blockSizeVertical * 25,
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                        maxLength: 200,
                        controller: _commentController,
                      ),
                    ],
                  ),
                ),
              )),
    );
  }

  Future<void> refresh() async {
    comments = await _postService.fetchCommentsForPost();
    print('BookDetailsViewModel.refresh comments has len ${comments.length}');
    notifyListeners();
  }
}
