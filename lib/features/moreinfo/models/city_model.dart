class CityModel {
  final String name;
  final String country;

  CityModel({
    required this.name,
    required this.country,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'] ?? '',
      country: json['country'] ?? '',
    );
  }
}