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

  User copyWith({String email, String name, String phone}) {
    return User(
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
