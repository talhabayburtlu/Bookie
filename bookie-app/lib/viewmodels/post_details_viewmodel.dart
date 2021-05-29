import 'package:bookie/app/locator.dart';
import 'package:bookie/app/router.gr.dart';
import 'package:bookie/models/book.dart';
import 'package:bookie/models/post.dart';
import 'package:bookie/models/user.dart';
import 'package:bookie/services/post_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PostDetailsViewModel extends BaseViewModel {
  final _postService = locator<PostService>();
  final _navigationService = locator<NavigationService>();

  Post get selectedPost => _postService.selectedPost;

  User get user => selectedPost.user;

  void showBookDetails(Book book) {
    _postService.selectBook(book);
    _navigationService.navigateTo(Routes.bookDetailsView);
  }
}
