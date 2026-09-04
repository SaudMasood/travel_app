class BookModel {
  final String title;
  final String author;
  final int year;

  BookModel({
    required this.title,
    required this.author,
    required this.year,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'] ?? '',
      author: json['author_name'] != null &&
          (json['author_name'] as List).isNotEmpty
          ? json['author_name'][0]
          : 'Unknown',
      year: json['first_publish_year'] ?? 0,
    );
  }
}