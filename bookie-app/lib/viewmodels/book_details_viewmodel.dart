import 'package:bookie/app/locator.dart';
import 'package:bookie/models/book.dart';
import 'package:bookie/services/post_service.dart';
import 'package:stacked/stacked.dart';

class BookDetailsViewModel extends BaseViewModel {
  final _postService = locator<PostService>();

  Book get selectedBook => _postService.selectedBook;
}
