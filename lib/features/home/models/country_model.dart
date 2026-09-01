class CountryModel {
  final String name;
  final String capital;
  final String region;
  final String flag;
  final String currency;
  final int population;
  final double latitude;
  final double longitude;

  CountryModel({
    required this.name,
    required this.capital,
    required this.region,
    required this.flag,
    required this.currency,
    required this.population,
    required this.latitude,
    required this.longitude,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'] ?? '',
      capital: json['capital'] ?? 'No capital',
      region: json['region'] ?? '',
      flag: json['flag'] ?? '',

      currency: json['currencies'] != null &&
          (json['currencies'] as List).isNotEmpty
          ? json['currencies'][0]['code'] ?? ''
          : '',

      population: json['population'] ?? 0,

      latitude: json['latlng'] != null
          ? (json['latlng'][0] as num).toDouble()
          : 0.0,

      longitude: json['latlng'] != null
          ? (json['latlng'][1] as num).toDouble()
          : 0.0,
    );
  }
}