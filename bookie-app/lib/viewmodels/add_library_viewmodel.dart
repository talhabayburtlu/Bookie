import 'package:bookie/app/locator.dart';
import 'package:bookie/models/book.dart';
import 'package:bookie/services/library_service.dart';
import 'package:stacked/stacked.dart';

class AddLibraryViewModel extends BaseViewModel {
  final _libraryService = locator<LibraryService>();
  List<Book> searchResults = [];

  Future<void> searchBooks(String query) async {
    setBusy(true);
    searchResults = await _libraryService.searchBooks(query);
    setBusy(false);
  }
}
