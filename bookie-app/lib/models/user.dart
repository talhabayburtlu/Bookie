import 'package:bookie/models/address.dart';

class User {
  // Represents the fullname name + ' ' + surname
  final String name;
  final String email;
  final String phone;
  final Address address;

  User({this.name, this.email, this.phone, this.address});

  User.mocked({
    this.name = "test",
    this.email = "test@test.com",
    this.phone = "123",
    this.address = const Address.mocked(),
  });

  static User fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
    try {
      return User(
          name: map["name"],
          email: map["email"],
          phone: map["phone"],
          address: Address.fromJson(map["address"]));
    } catch (e) {
      print('User.fromJson e: $e');
      return null;
    }
  }
}
