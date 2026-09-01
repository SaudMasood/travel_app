import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/api_service.dart';
import '../models/country_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService apiService;

  HomeBloc(this.apiService) : super(HomeInitial()) {
    on<SearchCountry>(_searchCountry);
  }

  Future<void> _searchCountry(
      SearchCountry event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoading());

    try {
      final data = await apiService.get(
        'https://countries.dev/alpha/${event.countrycode}',
      );

      final country = CountryModel.fromJson(data);

      emit(HomeLoaded([country]));
    } catch (e) {
      emit(
        HomeError(
          e.toString(),
        ),
      );
    }
  }
}