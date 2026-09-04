class TimeModel {
  final String sunrise;
  final String sunset;
  final String dawn;
  final String dusk;

  TimeModel({
    required this.sunrise,
    required this.sunset,
    required this.dawn,
    required this.dusk,
  });

  factory TimeModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final results = json['results'];

    return TimeModel(
      sunrise: results['sunrise'] ?? '',
      sunset: results['sunset'] ?? '',
      dawn: results['civil_twilight_begin'] ?? '',
      dusk: results['civil_twilight_end'] ?? '',
    );
  }
}