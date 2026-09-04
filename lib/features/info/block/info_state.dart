import 'package:equatable/equatable.dart';

import '../models/ip_location_model.dart';
import '../models/photo_model.dart';
import '../models/user_model.dart';
import '../models/dog_model.dart';

abstract class InfoState extends Equatable {
  const InfoState();

  @override
  List<Object?> get props => [];
}

class InfoInitial extends InfoState {
  const InfoInitial();
}

class InfoLoading extends InfoState {
  const InfoLoading();
}

class InfoLoaded extends InfoState {
  final IpLocationModel ipLocation;
  final List<PhotoModel> photos;
  final List<UserModel> users;
  final List<DogModel> dogs;
  final List<Map<String, dynamic>> countries;

  const InfoLoaded({
    required this.ipLocation,
    required this.photos,
    required this.users,
    required this.dogs,
    required this.countries,
  });

  @override
  List<Object?> get props => [
    ipLocation,
    photos,
    users,
    dogs,
    countries,
  ];
}

class InfoError extends InfoState {
  final String message;

  const InfoError(this.message);

  @override
  List<Object?> get props => [message];
}