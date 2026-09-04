class ElevationModel {
  final double elevation;
  final double latitude;
  final double longitude;

  ElevationModel({
    required this.elevation,
    required this.latitude,
    required this.longitude,
  });

  factory ElevationModel.fromJson(Map<String, dynamic> json) {
    return ElevationModel(
      elevation: (json['elevation'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}