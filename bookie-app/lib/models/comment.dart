import 'package:bookie/models/user.dart';
import 'package:intl/intl.dart';

class Comment {
  final int id;
  final String description;
  final String senderName;
  final int senderId;
  final DateTime timestamp;

  Comment(
      {this.timestamp,
      this.id,
      this.description,
      this.senderName,
      this.senderId});

  String get formattedDate {
    return DateFormat("dd/MM/yyyy hh:mm").format(timestamp);
  }

  static Comment fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    try {
      return Comment(
          timestamp: map["timestamp"] == null
              ? DateTime.now()
              : DateTime.parse(map["timestamp"]),
          id: map["id"],
          description: map["description"],
          senderId: map["senderId"],
          senderName: map["senderName"]);
    } catch (e) {
      print('Comment.fromJsone e: $e');
      return null;
    }
  }
}
