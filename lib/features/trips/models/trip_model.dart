class TripModel {
  final int id;
  final String destination;
  final String startDate;
  final String endDate;

  TripModel({
    required this.id,
    required this.destination,
    required this.startDate,
    required this.endDate,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] ?? 0,
      destination: json['destination'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}