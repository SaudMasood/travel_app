class LocationModel {
  final String displayName;
  final double latitude;
  final double longitude;

  LocationModel({
    required this.displayName,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      displayName: json['display_name'] ?? '',
      latitude: double.tryParse(json['lat'] ?? '') ?? 0.0,
      longitude: double.tryParse(json['lon'] ?? '') ?? 0.0,
    );
  }
}