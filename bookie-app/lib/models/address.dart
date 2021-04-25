class Address {
  final int id;
  final String name;

  Address({this.id, this.name});

  const Address.mocked({this.id = 0, this.name = "test"});

  static Address fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    try {
      return Address(id: map["id"], name: map["name"]);
    } catch (e) {
      print('Address.fromJson e: $e');
      return null;
    }
  }
}
