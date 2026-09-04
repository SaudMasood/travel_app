class IpLocationModel {
  final String ip;
  final String city;
  final String region;
  final String country;
  final String countryName;
  final String timezone;

  IpLocationModel({
    required this.ip,
    required this.city,
    required this.region,
    required this.country,
    required this.countryName,
    required this.timezone,
  });

  factory IpLocationModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return IpLocationModel(
      ip: json['ip'] ?? '',
      city: json['city'] ?? '',
      region: json['region'] ?? '',
      country: json['country_code'] ?? '',
      countryName: json['country'] ?? '',
      timezone: json['timezone']?['id'] ?? '',
    );
  }
}