class TravelNoteModel {
  final int id;
  final String title;
  final String body;

  TravelNoteModel({
    required this.id,
    required this.title,
    required this.body,
  });

  factory TravelNoteModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return TravelNoteModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'userId': 1,
    };
  }
}