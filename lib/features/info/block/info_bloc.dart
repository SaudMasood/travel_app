import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/api_service.dart';

import '../models/ip_location_model.dart';
import '../models/photo_model.dart';
import '../models/user_model.dart';
import '../models/dog_model.dart';

import 'info_event.dart';
import 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final ApiService apiService;

  InfoBloc(this.apiService) : super(const InfoInitial()) {
    on<LoadInfo>(_loadInfo);
  }

  Future<void> _loadInfo(
      LoadInfo event,
      Emitter<InfoState> emit,
      ) async {
    emit(const InfoLoading());

    try {
      print('API 1: IP Location');

      final ipResponse = await apiService.get(
        'https://ipwho.is/',
      );

      final ipLocation =
      IpLocationModel.fromJson(ipResponse);

      print('IP Location completed');

      print('API 2: Countries');

      final countriesResponse = await apiService.get(
        'https://countriesnow.space/api/v0.1/countries',
      );

      final List countriesData =
          countriesResponse['data'] ?? [];

      final List<Map<String, dynamic>> countries = [];

      for (final country in countriesData.take(10)) {
        countries.add({
          'name': {
            'common': country['country'] ?? '',
          },
          'region': '',
          'flags': {
            'png': '',
          },
        });
      }

      print('Countries completed');

      print('API 3: Photos');

      final photosResponse = await apiService.get(
        'https://picsum.photos/v2/list?limit=10',
      );

      final List<PhotoModel> photos =
      (photosResponse as List)
          .map(
            (json) => PhotoModel.fromJson(json),
      )
          .toList();

      print('Photos completed');

      print('API 4: Travelers');

      final usersResponse = await apiService.get(
        'https://randomuser.me/api/?results=10',
      );

      final List usersData =
          usersResponse['results'] ?? [];

      final List<UserModel> users =
      usersData
          .map(
            (json) => UserModel.fromJson(json),
      )
          .toList();

      print('Travelers completed');

      print('API 5: Dogs');

      final dogsResponse = await apiService.get(
        'https://dog.ceo/api/breeds/image/random/10',
      );

      final List dogsData =
          dogsResponse['message'] ?? [];

      final List<DogModel> dogs =
      dogsData
          .map(
            (image) => DogModel.fromJson(image),
      )
          .toList();

      print('Dogs completed');

      emit(
        InfoLoaded(
          ipLocation: ipLocation,
          photos: photos,
          users: users,
          dogs: dogs,
          countries: countries,
        ),
      );

      print('ALL INFO APIs COMPLETED');
    } catch (e) {
      print('INFO API ERROR: $e');

      emit(
        InfoError(
          e.toString(),
        ),
      );
    }
  }
}