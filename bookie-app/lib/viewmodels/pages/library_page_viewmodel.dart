import 'package:bookie/app/locator.dart';
import 'package:bookie/models/book.dart';
import 'package:bookie/services/library_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LibraryPageViewModel extends FutureViewModel {
  final _libraryService = locator<LibraryService>();
  final _dialogService = locator<DialogService>();

  List<ReactiveServiceMixin> _reactiveServices = [];

  List<Book> get books => _libraryService.libraryBooks;

  LibraryPageViewModel() {
    _reactiveServices = [_libraryService];
    _reactToServices(_reactiveServices);
  }

  void _reactToServices(List<ReactiveServiceMixin> reactiveServices) {
    _reactiveServices = reactiveServices;
    for (var reactiveService in _reactiveServices) {
      reactiveService.addListener(_indicateChange);
    }
  }

  @override
  void dispose() {
    for (var reactiveService in _reactiveServices) {
      reactiveService.removeListener(_indicateChange);
    }
    super.dispose();
  }

  void _indicateChange() {
    notifyListeners();
  }

  @override
  Future futureToRun() async {
    await _libraryService.getOwnLibrary();
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
    setBusy(false);
    notifyListeners();
  }

  Future<void> updateBookStatus(Book book) async {
    /*
    Always toggles the status:
     */
    final isAvailable = book.isAvailable;
    final newType = isAvailable ? 'Unavailable' : 'Available';

    final res = await _dialogService.showConfirmationDialog(
        title: "Confirm setting this book as $newType",
        description: "You are about to set ${book.title} as $newType",
        barrierDismissible: true);
    if (res.confirmed == false) {
      return;
    }
    setBusy(true);

    await _libraryService.updateStatus(book, newType);
    setBusy(false);
  }
}
