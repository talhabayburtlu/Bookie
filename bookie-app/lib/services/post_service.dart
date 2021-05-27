import 'package:bookie/app/locator.dart';
import 'package:bookie/models/post.dart';
import 'package:bookie/services/http_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PostService {
  final _httpService = locator<HttpService>();

  Future<List<Post>> fetchPostsForUser() async {
    await Future.delayed(Duration(seconds: 2));
    return [for (int i = 0; i < 3; i++) Post.mocked()];
  }
}
