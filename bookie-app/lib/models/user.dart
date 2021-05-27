import 'package:bookie/models/address.dart';

class User {
  // Represents the fullname name + ' ' + surname
  final String name;
  final String email;
  final String phone;
  final String city;

  User({this.name, this.email, this.phone, this.city});

  const User.mocked(
      {this.name = "Tester Tester",
      this.email = "test@test.com",
      this.phone = "123",
      this.city = "Istanbul"});

  static User fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
    try {
      return User(
        name: map["fullname"],
        email: map["email"],
        phone: map["phone"],
        city: map["city"],
      );
    } catch (e) {
      print('User.fromJson e: $e');
      return null;
    }
  }

  @override
  String toString() {
    return "<$name - $email>";
  }
}
