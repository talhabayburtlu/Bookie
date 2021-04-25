import 'package:bookie/models/post.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PostService {
  Future<List<Post>> fetchPostsForUser() async {
    await Future.delayed(Duration(seconds: 2));
    return [for (int i = 0; i < 3; i++) Post.mocked()];
  }
}
