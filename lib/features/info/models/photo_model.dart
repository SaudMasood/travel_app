class PhotoModel {
  final int id;
  final String author;
  final String downloadUrl;

  PhotoModel({
    required this.id,
    required this.author,
    required this.downloadUrl,
  });

  factory PhotoModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return PhotoModel(
      id: int.tryParse(
        json['id'].toString(),
      ) ??
          0,
      author: json['author'] ?? '',
      downloadUrl: json['download_url'] ?? '',
    );
  }
}