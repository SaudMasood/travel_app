import 'package:equatable/equatable.dart';

class MoreInfoEvent extends Equatable {
  const MoreInfoEvent();

  @override
  List<Object?> get props => [];
}

class LoadMoreInfo extends MoreInfoEvent {
  final String countryCode;
  final String city;
  final double latitude;
  final double longitude;

  const LoadMoreInfo({
    required this.countryCode,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
    countryCode,
    city,
    latitude,
    longitude,
  ];
}