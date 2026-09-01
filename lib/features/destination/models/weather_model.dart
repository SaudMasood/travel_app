class WeatherModel {
  final double temperature;
  final double humidity;
  final double apparentTemperature;
  final int weatherCode;
  final double windSpeed;

  WeatherModel({
    required this.temperature,
    required this.humidity,
    required this.apparentTemperature,
    required this.weatherCode,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'];

    return WeatherModel(
      temperature: (current['temperature_2m'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).toDouble(),
      apparentTemperature:
      (current['apparent_temperature'] as num).toDouble(),
      weatherCode: current['weather_code'] ?? 0,
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
    );
  }
}