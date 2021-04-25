import 'package:bookie/app/locator.dart';
import 'package:bookie/models/post.dart';
import 'package:bookie/services/post_service.dart';
import 'package:stacked/stacked.dart';

class HomePageViewModel extends FutureViewModel<List<Post>> {
  final PostService _postService = locator<PostService>();

  @override
  Future<List<Post>> futureToRun() => _postService.fetchPostsForUser();
}
