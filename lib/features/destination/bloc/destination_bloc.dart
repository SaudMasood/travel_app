import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/api_service.dart';
import '../models/weather_model.dart';
import '../models/air_quality_model.dart';
import '../models/currency_model.dart';
import '../models/news_model.dart';

import 'destination_event.dart';
import 'destination_state.dart';

class DestinationBloc extends Bloc<DestinationEvent, DestinationState> {
  final ApiService apiService;

  DestinationBloc(this.apiService)
      : super(const DestinationInitial()) {
    on<LoadDestination>(_loadDestination);
  }

  Future<void> _loadDestination(
      LoadDestination event,
      Emitter<DestinationState> emit,
      ) async {
    emit(const DestinationLoading());

    try {
      final country = event.country;

      final weatherResponse = await apiService.get(
        'https://api.open-meteo.com/v1/forecast?latitude=${country.latitude}&longitude=${country.longitude}&current=temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,wind_speed_10m&timezone=auto',
      );

      final weather = WeatherModel.fromJson(weatherResponse);


      final airQualityResponse = await apiService.get(
        'https://air-quality-api.open-meteo.com/v1/air-quality?latitude=${country.latitude}&longitude=${country.longitude}&current=pm10,pm2_5,carbon_monoxide,nitrogen_dioxide,sulphur_dioxide,ozone&timezone=auto',
      );

      final airQuality =
      AirQualityModel.fromJson(airQualityResponse);
      final currencyResponse = await apiService.get(
        'https://api.frankfurter.dev/v2/rates?base=${country.currency}',
      );

      final List<dynamic> currencyResults = currencyResponse;

      final List<CurrencyModel> currencies = currencyResults
          .map((json) => CurrencyModel.fromJson(json))
          .toList();


      final newsResponse = await apiService.get(
        'https://freenewsapi.ai/v1/search'
            '?q=${Uri.encodeComponent(country.name)}'
            '&size=5',
      );

      final List<dynamic> results = newsResponse['results'];

      final List<NewsModel> news = results
          .map((json) => NewsModel.fromJson(json))
          .toList();

      emit(
        DestinationLoaded(
          country: country,
          weather: weather,
          airQuality: airQuality,
          currencies: currencies,
          news: news,
        ),
      );
    } catch (e) {
      emit(
        DestinationError(e.toString()),
      );
    }
  }
}