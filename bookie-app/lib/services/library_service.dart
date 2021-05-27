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

  Future<bool> addBooks(List<Book> books) async {
    try {
      for (Book book in books) {
        final res = await _httpService.post(path: 'user/addBook/${book.id}');
        print('AddLibraryViewModel.saveBooks res: $res');
      }
      return true;
    } catch (e) {
      print('LibraryService.addBooks e: $e');
      return false;
    }
  }

  Future<bool> removeBook(Book book) async {
    try {
      final res = await _httpService.delete(
          path: "user/deleteBook", queryParams: "?bookId=${book.id}");
      return true;
    } catch (e) {
      print('LibraryService.removeBook e: $e');
      return false;
    }
  }
}
