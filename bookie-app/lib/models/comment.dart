import 'package:bookie/models/user.dart';

class Comment {
  final int id;
  final String description;
  final User sender;
  final User receiver;

  Comment({this.id, this.description, this.sender, this.receiver});

  static Comment fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    try {
      return Comment(
          id: map["id"],
          description: map["description"],
          receiver: User.fromJson(map["receiver"]),
          sender: User.fromJson(map["sender"]));
    } catch (e) {
      print('Comment.fromJsone e: $e');
      return null;
    }
  }
}
