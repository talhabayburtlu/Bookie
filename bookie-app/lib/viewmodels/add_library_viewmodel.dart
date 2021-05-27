import 'package:bookie/app/locator.dart';
import 'package:bookie/models/book.dart';
import 'package:bookie/services/http_service.dart';
import 'package:bookie/services/library_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddLibraryViewModel extends BaseViewModel {
  final _libraryService = locator<LibraryService>();
  final _httpService = locator<HttpService>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  List<Book> searchResults = [];

  List<Book> selectedBooks = [];

  bool get showFAB => selectedBooks.isNotEmpty;

  void selectBook(Book book) {
    if (selectedBooks.contains(book)) {
      selectedBooks.remove(book);
    } else {
      selectedBooks.add(book);
    }
    notifyListeners();
  }

  void saveBooks() async {
    try {
      setBusy(true);
      _libraryService.addBooks(selectedBooks);
      setBusy(false);
      _navigationService.back();
      _snackbarService.showSnackbar(message: "Successfully added books");
    } catch (e) {
      print('AddLibraryViewModel.saveBooks e: $e');
      setBusy(false);
    }
  }

  bool isSelected(Book book) {
    return selectedBooks.contains(book);
  }

  Future<void> searchBooks(String query) async {
    setBusy(true);
    searchResults = await _libraryService.searchBooks(query);
    setBusy(false);
  }
}
