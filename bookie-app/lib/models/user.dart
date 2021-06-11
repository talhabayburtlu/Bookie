class User {
  // Represents the fullname name + ' ' + surname
  final int id;
  final String name;
  final String email;
  final String phone;
  final String city;

  User({this.id, this.name, this.email, this.phone, this.city});

  User copyWith({String email, String name, String phone}) {
    return User(
        id: this.id,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        city: this.city);
  }

  static User fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
    try {
      return User(
        id: map["id"],
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
