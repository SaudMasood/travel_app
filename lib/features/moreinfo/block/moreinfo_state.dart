import 'package:equatable/equatable.dart';

import '../models/holiday_model.dart';
import '../models/sunrise_model.dart';
import '../models/location_model.dart';
import '../models/elevation_model.dart';
import '../models/wikipedia_model.dart';
import '../models/book_model.dart';
import '../models/city_model.dart';

abstract class MoreInfoState extends Equatable {
  const MoreInfoState();

  @override
  List<Object?> get props => [];
}

class MoreInfoInitial extends MoreInfoState {
  const MoreInfoInitial();
}

class MoreInfoLoading extends MoreInfoState {
  const MoreInfoLoading();
}

class MoreInfoLoaded extends MoreInfoState {
  final List<HolidayModel> holidays;
  final SunriseModel sunrise;
  final List<LocationModel> locations;
  final ElevationModel elevation;
  final WikipediaModel wikipedia;
  final List<BookModel> books;
  final List<CityModel> cities;

  const MoreInfoLoaded({
    required this.holidays,
    required this.sunrise,
    required this.locations,
    required this.elevation,
    required this.wikipedia,
    required this.books,
    required this.cities,
  });

  @override
  List<Object?> get props => [
    holidays,
    sunrise,
    locations,
    elevation,
    wikipedia,
    books,
    cities,
  ];
}

class MoreInfoError extends MoreInfoState {
  final String message;

  const MoreInfoError(this.message);

  @override
  List<Object?> get props => [message];
}