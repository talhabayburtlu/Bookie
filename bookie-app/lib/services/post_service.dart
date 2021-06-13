import 'package:bookie/app/locator.dart';
import 'package:bookie/models/book.dart';
import 'package:bookie/models/comment.dart';
import 'package:bookie/models/post.dart';
import 'package:bookie/services/auth_service.dart';
import 'package:bookie/services/http_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PostService {
  final _httpService = locator<HttpService>();
  final _authService = locator<AuthService>();

  Post _selectedPost;
  Book _selectedBook;

  Post get selectedPost => _selectedPost;

  Book get selectedBook => _selectedBook;

  bool _ownLibrary;

  bool get ownLibrary => _ownLibrary;

  void setOwnLibrary(bool val) {
    _ownLibrary = val;
  }

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

  Future<List<Comment>> fetchCommentsForPost() async {
    try {
      final userId = _ownLibrary ? _authService.user.id : _selectedPost.user.id;
      final bookId = _selectedBook.id;

      final List<dynamic> res = await _httpService.get(
          path: "post/getCommentsByUserIdAndBookId",
          queryParams: "?userId=$userId&bookId=$bookId");
      List<Comment> comments = [];

      res.forEach((c) {
        comments.add(Comment.fromJson(c));
      });

      return comments ?? [];
    } catch (e) {
      print('PostService.fetchCommentsForPost e: $e');
      return [];
    }
  }

  Future<bool> addComment(String content) async {
    try {
      final res = await _httpService.post(path: "user/toComment", body: {
        'ownerId': _ownLibrary ? _authService.user.id : _selectedPost.user.id,
        'bookId': _selectedBook.id,
        'content': content
      });
      if (res == null) {
        return false;
      }
      return true;
    } catch (e) {
      print('PostService.addComment e: $e');
      return false;
    }
  }
}
