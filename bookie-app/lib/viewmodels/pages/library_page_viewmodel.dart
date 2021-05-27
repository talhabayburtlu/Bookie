import 'package:bookie/app/locator.dart';
import 'package:bookie/models/book.dart';
import 'package:bookie/services/library_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LibraryPageViewModel extends FutureViewModel {
  final _libraryService = locator<LibraryService>();
  final _dialogService = locator<DialogService>();

  List<Book> books = [];

  @override
  Future futureToRun() async {
    books = await _libraryService.getOwnLibrary();
  }

  void removeFromLibrary(Book book) async {
    final res = await _dialogService.showConfirmationDialog(
        title: "Confirm deletion? ",
        description:
            "Please confirm that you want to remove ${book.title} from your library");
    if (res.confirmed == false) {
      return;
    }

    setBusy(true);
    await _libraryService.removeBook(book);
    books = await _libraryService.getOwnLibrary();
    setBusy(false);
    notifyListeners();
  }
}
