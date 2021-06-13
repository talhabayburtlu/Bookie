import 'package:bookie/app/locator.dart';
import 'package:bookie/app/router.gr.dart';
import 'package:bookie/models/book.dart';
import 'package:bookie/models/post.dart';
import 'package:bookie/models/user.dart';
import 'package:bookie/services/post_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailsViewModel extends BaseViewModel {
  final _postService = locator<PostService>();
  final _navigationService = locator<NavigationService>();

  Post get selectedPost => _postService.selectedPost;

  User get user => selectedPost.user;

  void showBookDetails(Book book) {
    _postService.setOwnLibrary(false);
    _postService.selectBook(book);
    _navigationService.navigateTo(Routes.bookDetailsView);
  }

  Future<void> launchWhatsapp() async {
    final phoneNumber = selectedPost.user.phone;
    final whatsappUrl = "whatsapp://send?phone=$phoneNumber";

    print('PostDetailsViewModel.launchWhatsapp phone: $phoneNumber');

    await launch(whatsappUrl);
  }

  Future<void> launchSms() async {
    final phoneNumber = selectedPost.user.phone;
    final smsUrl = 'sms:$phoneNumber';
    await launch(smsUrl);
  }

  Future<void> launchCall() async {
    final phoneNumber = selectedPost.user.phone;
    final callUrl = "tel://$phoneNumber";
    await launch(callUrl);
  }
}
