import 'package:bookie/app/locator.dart';
import 'package:bookie/app/router.gr.dart';
import 'package:bookie/models/post.dart';
import 'package:bookie/services/post_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomePageViewModel extends FutureViewModel<List<Post>> {
  final PostService _postService = locator<PostService>();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Future<List<Post>> futureToRun() => _postService.fetchPostsForUser();

  void showPostDetails(Post post) {
    _postService.selectPost(post);
    _navigationService.navigateTo(Routes.postDetailsView);
  }
}
