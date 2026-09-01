import 'package:equatable/equatable.dart';

import '../../home/models/country_model.dart';
import '../models/air_quality_model.dart';
import '../models/currency_model.dart';
import '../models/news_model.dart';
import '../models/weather_model.dart';


abstract class DestinationState extends Equatable {
  const DestinationState();

  @override
  List<Object?> get props => [];
}

class DestinationInitial extends DestinationState {
  const DestinationInitial();
}

class DestinationLoading extends DestinationState {
  const DestinationLoading();
}
class DestinationLoaded extends DestinationState {
  final CountryModel country;
  final WeatherModel weather;
  final AirQualityModel airQuality;
  final List<CurrencyModel> currencies;
  final List<NewsModel> news;

  const DestinationLoaded({
    required this.country,
    required this.weather,
    required this.airQuality,
    required this.currencies,
    required this.news,
  });

  @override
  List<Object?> get props => [
    country,
    weather,
    airQuality,
    currencies,
    news,
  ];
}

class DestinationError extends DestinationState {
  final String message;

  const DestinationError(this.message);

  @override
  List<Object?> get props => [message];
}