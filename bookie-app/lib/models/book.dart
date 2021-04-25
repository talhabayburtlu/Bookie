class Book {
  final String id;
  final String title;
  final String subtitle;
  final String author;
  final String isbn;
  final String description;
  final String imageSmallThumbnailLink;
  final String imageThumbnailLink;

  Book(
      {this.id,
      this.title,
      this.subtitle,
      this.author,
      this.isbn,
      this.description,
      this.imageSmallThumbnailLink,
      this.imageThumbnailLink});

  const Book.mocked(
      {this.id = "0",
      this.title = "Test",
      this.subtitle = "Test subtitle",
      this.author = "author",
      this.isbn = "123",
      this.description = "description",
      this.imageThumbnailLink =
          "https://nalport.com/image/cache/catalog/kitap/hayvan-ciftligi-(yeni-kapak)---george-orwell-img-550x550.png",
      this.imageSmallThumbnailLink =
          "https://nalport.com/image/cache/catalog/kitap/hayvan-ciftligi-(yeni-kapak)---george-orwell-img-550x550.png"});

  static Book fromJson(Map<String, dynamic> map) {
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
        imageThumbnailLink: map["imageThumbnailLink"]);
  }
}
