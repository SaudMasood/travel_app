class WikipediaModel {
  final String title;
  final String description;
  final String extract;
  final String imageUrl;

  WikipediaModel({
    required this.title,
    required this.description,
    required this.extract,
    required this.imageUrl,
  });

  factory WikipediaModel.fromJson(Map<String, dynamic> json) {
    return WikipediaModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      extract: json['extract'] ?? '',
      imageUrl: json['thumbnail'] != null
          ? json['thumbnail']['source'] ?? ''
          : '',
    );
  }
}