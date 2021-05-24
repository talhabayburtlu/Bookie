import 'package:bookie/app/locator.dart';
import 'package:bookie/models/book.dart';
import 'package:bookie/services/library_service.dart';
import 'package:stacked/stacked.dart';

class LibraryPageViewModel extends FutureViewModel {
  final _libraryService = locator<LibraryService>();
  List<Book> books = [];

  @override
  Future futureToRun() async {
    books = await _libraryService.getOwnLibrary();
  }
}
