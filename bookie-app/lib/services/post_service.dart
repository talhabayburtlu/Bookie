import 'package:bookie/app/locator.dart';
import 'package:bookie/models/post.dart';
import 'package:bookie/services/http_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PostService {
  final _httpService = locator<HttpService>();

  Future<List<Post>> fetchPostsForUser() async {
    try {
      final List<dynamic> res =
          await _httpService.get(path: 'user/getHomepagePosts');

      if (res == null) {
        return [];
      }

      List<Post> posts = [];
      res.forEach((postData) {
        posts.add(Post.fromJson(postData));
      });
      return posts;
    } catch (e) {
      print('PostService.fetchPostsForUser e: $e');
      return [];
    }
  }
}
