class Book {
  final String id;
  final String title;
  final String subtitle;
  final String author;
  final String isbn;
  final String description;
  final String imageSmallThumbnailLink;
  final String imageThumbnailLink;
  final String status; //Available | Unavailable

  Book(
      {this.id,
      this.title,
      this.subtitle,
      this.author,
      this.isbn,
      this.description,
      this.imageSmallThumbnailLink,
      this.imageThumbnailLink,
      this.status});

  bool get isAvailable {
    return this.status == "Available";
  }

  static Book fromJson(Map<String, dynamic> map) {
    try {
      if (map == null) {
        return null;
      }

      return Book(
          id: map["id"],
          title: map["title"],
          description: map["description"],
          author: map["author"],
          isbn: map["isbn"],
          subtitle: map["subtitle"],
          imageSmallThumbnailLink: map["imageSmallThumbnailLink"],
          imageThumbnailLink: map["imageThumbnailLink"],
          status: map["status"]);
    } catch (e) {
      print('Book.fromJson e: $e');
      return null;
    }
  }

  @override
  bool operator ==(covariant Book other) {
    return this.id == other.id && this.title == other.title;
  }

  @override
  int get hashCode => this.id.hashCode;

  @override
  String toString() {
    return "<$id $title $author>";
  }
}
