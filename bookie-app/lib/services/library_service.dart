import 'package:bookie/app/locator.dart';
import 'package:bookie/models/book.dart';
import 'package:injectable/injectable.dart';

import 'http_service.dart';

@lazySingleton
class LibraryService {
  final _httpService = locator<HttpService>();

  Future<List<Book>> getOwnLibrary() async {
    try {
      final List<dynamic> res = await _httpService.get(path: "user/getBooks");
      if (res == null) {
        return [];
      }
      List<Book> books = [];
      print('LibraryService.getOwnLibrary res: $res');
      res.forEach((book) {
        books.add(Book.fromJson(book));
      });
      return books;
    } catch (e) {
      print('LibraryService.getOwnLibrary e: $e');
      return [];
    }
  }

  Future<List<Book>> searchBooks(String searchQuery) async {
    try {
      final List<dynamic> res = await _httpService.get(
          path: "book/search", queryParams: "?title=$searchQuery");
      if (res == null) {
        return [];
      }
      List<Book> books = [];
      print('LibraryService.searchBooks res: $res');
      res.forEach((book) {
        books.add(Book.fromJson(book));
      });
      return books;
    } catch (e) {
      print('LibraryService.searchBooks e: $e');
      return [];
    }
  }
}
