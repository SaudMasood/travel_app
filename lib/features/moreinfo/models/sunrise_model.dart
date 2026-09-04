class SunriseModel {
  final String sunrise;
  final String sunset;
  final String dawn;
  final String dusk;

  SunriseModel({
    required this.sunrise,
    required this.sunset,
    required this.dawn,
    required this.dusk,
  });

  factory SunriseModel.fromJson(Map<String, dynamic> json) {
    final results = json['results'];

    return SunriseModel(
      sunrise: results['sunrise'] ?? '',
      sunset: results['sunset'] ?? '',
      dawn: results['civil_twilight_begin'] ?? '',
      dusk: results['civil_twilight_end'] ?? '',
    );
  }
}