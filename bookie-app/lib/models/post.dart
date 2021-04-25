import 'package:bookie/models/user.dart';

import 'book.dart';

class Post {
  final User user;
  final List<Book> books;

  Post({this.user, this.books});

  Post.mocked(
      {this.user = const User.mocked(),
      this.books = const [
        Book.mocked(),
        Book.mocked(),
        Book.mocked(),
      ]});

  static Post fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
    try {
      final List<dynamic> booksJson = map["books"];
      final List<Book> books = [];
      booksJson.forEach((bookJson) {
        books.add(Book.fromJson(bookJson));
      });

      return Post(user: User.fromJson(map["user"]), books: books);
    } catch (e) {
      print('Post.fromJson e: $e');
      return null;
    }
  }
}
