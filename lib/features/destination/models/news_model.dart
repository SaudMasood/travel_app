class NewsModel {
  final String id;
  final String title;
  final String description;
  final String link;
  final String publishedAt;
  final String host;
  final String imageUrl;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.link,
    required this.publishedAt,
    required this.host,
    required this.imageUrl,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      link: json['url'] ?? '',
      publishedAt: json['published_at'] ?? '',
      host: json['host'] ?? '',
      imageUrl: json['image'] ?? '',
    );
  }
}