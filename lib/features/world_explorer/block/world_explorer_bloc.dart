import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/api_service.dart';

import '../models/country_info_model.dart';
import '../models/time_model.dart';
import '../models/population_model.dart';
import '../models/currency_model.dart';
import '../models/book_model.dart';

import 'world_explorer_event.dart';
import 'world_explorer_state.dart';

class WorldExplorerBloc
    extends Bloc<WorldExplorerEvent, WorldExplorerState> {

  final ApiService apiService;

  WorldExplorerBloc(this.apiService)
      : super(const WorldExplorerInitial()) {

    on<SearchCountry>(_searchCountry);
  }

  Future<void> _searchCountry(
      SearchCountry event,
      Emitter<WorldExplorerState> emit,
      ) async {

    emit(const WorldExplorerLoading());

    try {

      print('API 1: Country');

      final countryResponse = await apiService.get(
        'https://countries.dev/alpha/'
            '${event.country.trim().toUpperCase()}',
      );

      final country =
      CountryInfoModel.fromJson(countryResponse);

      print('Country API completed');

      print('API 2: Sunrise');

      final latitude =
      countryResponse['latlng'][0];

      final longitude =
      countryResponse['latlng'][1];

      final sunriseResponse = await apiService.get(
        'https://api.sunrise-sunset.org/json'
            '?lat=$latitude'
            '&lng=$longitude'
            '&date=today',
      );

      final time =
      TimeModel.fromJson(sunriseResponse);

      print('Sunrise API completed');

      print('API 3: Wikipedia');

      final wikipediaResponse = await apiService.get(
        'https://en.wikipedia.org/api/rest_v1/page/summary/'
            '${Uri.encodeComponent(country.name)}',
      );

      final wikipedia =
          wikipediaResponse['extract'] ?? '';

      print('Wikipedia API completed');

      print('API 4: World Bank');

      final populationResponse = await apiService.get(
        'https://api.worldbank.org/v2/country/'
            '${countryResponse['alpha2Code']}'
            '/indicator/SP.POP.TOTL'
            '?format=json&per_page=1',
      );

      final populationData =
      populationResponse[1][0];

      final population = PopulationModel(
        country: country.name,
        population:
        populationData['value'] ?? 0,
        year: int.tryParse(
          populationData['date'].toString(),
        ) ?? 0,
      );

      print('World Bank API completed');

      print('API 5: Currency');

      List<CurrencyModel> currencies = [];

      try {
        final currencyResponse = await apiService.get(
          'https://api.frankfurter.dev/v2/rates'
              '?base=${country.currency}'
              '&quotes=USD,EUR,GBP',
        );

        final List currencyResults = currencyResponse;

        currencies = currencyResults
            .map(
              (json) => CurrencyModel.fromJson(json),
        )
            .toList();

        print('Currency API completed');

      } catch (e) {
        print('Currency API failed: $e');
      }

      print('API 6: Books');

      final bookResponse = await apiService.get(
        'https://openlibrary.org/search.json'
            '?q=travel%20${Uri.encodeComponent(country.name)}'
            '&limit=5',
      );

      final List bookResults =
          bookResponse['docs'] ?? [];

      final List<BookModel> books =
      bookResults
          .map(
            (json) => BookModel.fromJson(json),
      )
          .toList();

      print('Books API completed');

      emit(
        WorldExplorerLoaded(
          country: country,
          time: time,
          population: population,
          wikipedia: wikipedia,
          currencies: currencies,
          books: books,
        ),
      );

      print('ALL APIs COMPLETED');

    } catch (e) {

      print('API ERROR: $e');

      emit(
        WorldExplorerError(
          e.toString(),
        ),
      );
    }
  }
}