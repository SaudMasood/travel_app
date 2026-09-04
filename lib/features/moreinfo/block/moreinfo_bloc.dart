import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/api_service.dart';

import '../models/holiday_model.dart';
import '../models/sunrise_model.dart';
import '../models/location_model.dart';
import '../models/elevation_model.dart';
import '../models/wikipedia_model.dart';
import '../models/book_model.dart';
import '../models/city_model.dart';

import 'moreinfo_event.dart';
import 'moreinfo_state.dart';

class MoreInfoBloc extends Bloc<MoreInfoEvent, MoreInfoState> {
  final ApiService apiService;

  MoreInfoBloc(this.apiService)
      : super(const MoreInfoInitial()) {
    on<LoadMoreInfo>(_loadMoreInfo);
  }

  Future<void> _loadMoreInfo(
      LoadMoreInfo event,
      Emitter<MoreInfoState> emit,
      ) async {
    emit(const MoreInfoLoading());

    try {
      final holidayResponse = await apiService.get(
        'https://date.nager.at/api/v3/PublicHolidays/2026/'
            '${event.countryCode.toUpperCase()}',
      );

      final List<HolidayModel> holidays =
      (holidayResponse as List)
          .map(
            (json) => HolidayModel.fromJson(json),
      )
          .toList();

      final sunriseResponse = await apiService.get(
        'https://api.sunrise-sunset.org/json'
            '?lat=${event.latitude}'
            '&lng=${event.longitude}'
            '&date=today',
      );

      final sunrise =
      SunriseModel.fromJson(sunriseResponse);

      final locationResponse = await apiService.get(
        'https://nominatim.openstreetmap.org/search'
            '?q=${Uri.encodeComponent(event.city)}'
            '&format=jsonv2'
            '&limit=5',
      );

      final List<LocationModel> locations =
      (locationResponse as List)
          .map(
            (json) => LocationModel.fromJson(json),
      )
          .toList();

      final elevationResponse = await apiService.get(
        'https://api.open-elevation.com/api/v1/lookup'
            '?locations=${event.latitude},${event.longitude}',
      );

      final List elevationResults =
      elevationResponse['results'];

      final elevation =
      ElevationModel.fromJson(
        elevationResults.first,
      );

      final wikipediaResponse = await apiService.get(
        'https://en.wikipedia.org/api/rest_v1/page/summary/'
            '${Uri.encodeComponent(event.city)}',
      );

      final wikipedia =
      WikipediaModel.fromJson(wikipediaResponse);

      final bookResponse = await apiService.get(
        'https://openlibrary.org/search.json'
            '?q=${Uri.encodeComponent('travel ${event.city}')}'
            '&limit=5',
      );

      final List bookResults =
      bookResponse['docs'];

      final List<BookModel> books =
      bookResults
          .map(
            (json) => BookModel.fromJson(json),
      )
          .toList();

      final cityResponse = await apiService.get(
        'https://geocoding-api.open-meteo.com/v1/search'
            '?name=${Uri.encodeComponent(event.city)}'
            '&count=5'
            '&language=en'
            '&format=json',
      );

      final List cityResults =
          cityResponse['results'] ?? [];

      final List<CityModel> cities =
      cityResults
          .map(
            (json) => CityModel.fromJson(json),
      )
          .toList();

      emit(
        MoreInfoLoaded(
          holidays: holidays,
          sunrise: sunrise,
          locations: locations,
          elevation: elevation,
          wikipedia: wikipedia,
          books: books,
          cities: cities,
        ),
      );
    } catch (e) {
      emit(
        MoreInfoError(
          e.toString(),
        ),
      );
    }
  }
}