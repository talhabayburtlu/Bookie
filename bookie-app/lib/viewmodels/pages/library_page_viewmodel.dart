import 'package:bookie/app/locator.dart';
import 'package:bookie/app/router.gr.dart';
import 'package:bookie/models/book.dart';
import 'package:bookie/services/library_service.dart';
import 'package:bookie/services/post_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LibraryPageViewModel extends FutureViewModel {
  final _libraryService = locator<LibraryService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _postService = locator<PostService>();

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

  void showBookDetails(Book book) {
    _postService.setOwnLibrary(true);
    _postService.selectBook(book);
    _navigationService.navigateTo(Routes.bookDetailsView);
  }
}
