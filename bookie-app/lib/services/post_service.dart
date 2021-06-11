import 'package:bookie/app/locator.dart';
import 'package:bookie/models/book.dart';
import 'package:bookie/models/post.dart';
import 'package:bookie/services/http_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PostService {
  final _httpService = locator<HttpService>();

  Post _selectedPost;
  Book _selectedBook;

  Post get selectedPost => _selectedPost;

  Book get selectedBook => _selectedBook;

  void selectPost(Post post) {
    _selectedPost = post;
  }

  void selectBook(Book book) {
    _selectedBook = book;
  }

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

  Future<List<dynamic>> fetchCommentsForPost() async {
    try {
      final userId = _selectedPost.user.id;
      final bookId = _selectedBook.id;

      final List<dynamic> res = await _httpService.get(
          path: "post/getCommentsByUserIdAndBookId",
          queryParams: "?userId=$userId&bookId=$bookId");
    } catch (e) {
      print('PostService.fetchCommentsForPost e: $e');
      return [];
    }
  }

  Future<bool> addComment() {}
}
