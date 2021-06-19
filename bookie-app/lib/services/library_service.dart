import 'package:bookie/app/locator.dart';
import 'package:bookie/models/book.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import 'http_service.dart';
import 'package:observable_ish/observable_ish.dart';

@lazySingleton
class LibraryService with ReactiveServiceMixin {
  final _httpService = locator<HttpService>();

  LibraryService() {
    listenToReactiveValues([_libraryBooks]);
  }

  RxValue<List<Book>> _libraryBooks = RxValue<List<Book>>(initial: []);

  List<Book> get libraryBooks => _libraryBooks.value;

  void updateLibrary(List<Book> books) {
    _libraryBooks.value = books;
  }

  Future<void> getOwnLibrary() async {
    try {
      final List<dynamic> res = await _httpService.get(path: "user/getBooks");
      if (res == null) {
        return [];
      }
      List<Book> books = [];
      res.forEach((book) {
        books.add(Book.fromJson(book));
      });
      updateLibrary(books);
    } catch (e) {
      print('LibraryService.getOwnLibrary e: $e');
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
        if (book != null) {
          books.add(Book.fromJson(book));
        }
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
        await getOwnLibrary();
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
      await getOwnLibrary();
      return true;
    } catch (e) {
      print('LibraryService.removeBook e: $e');
      return false;
    }
  }

  Future<bool> updateStatus(Book book, String status) async {
    try {
      final res = await _httpService.post(
          path: "post/status", body: {"bookId": book.id, "status": status});
      await getOwnLibrary();
      return true;
    } catch (e) {
      print('LibraryService.updateStatus e: $e');
      return false;
    }
  }
}
