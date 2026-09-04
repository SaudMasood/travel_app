class HolidayModel {
  final String date;
  final String localName;
  final String name;
  final String countryCode;

  HolidayModel({
    required this.date,
    required this.localName,
    required this.name,
    required this.countryCode,
  });

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      date: json['date'] ?? '',
      localName: json['localName'] ?? '',
      name: json['name'] ?? '',
      countryCode: json['countryCode'] ?? '',
    );
  }
}