class AirQualityModel {
  final double pm10;
  final double pm2_5;
  final double carbonMonoxide;
  final double nitrogenDioxide;
  final double sulphurDioxide;
  final double ozone;

  AirQualityModel({
    required this.pm10,
    required this.pm2_5,
    required this.carbonMonoxide,
    required this.nitrogenDioxide,
    required this.sulphurDioxide,
    required this.ozone,
  });

  factory AirQualityModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'];

    return AirQualityModel(
      pm10: (current['pm10'] as num).toDouble(),
      pm2_5: (current['pm2_5'] as num).toDouble(),
      carbonMonoxide:
      (current['carbon_monoxide'] as num).toDouble(),
      nitrogenDioxide:
      (current['nitrogen_dioxide'] as num).toDouble(),
      sulphurDioxide:
      (current['sulphur_dioxide'] as num).toDouble(),
      ozone: (current['ozone'] as num).toDouble(),
    );
  }
}