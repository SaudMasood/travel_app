import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/api_service.dart';
import '../models/trip_model.dart';
import 'trip_event.dart';
import 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final ApiService apiService;

  List<TripModel> trips = [];

  TripBloc(this.apiService) : super(const TripInitial()) {
    on<LoadTrips>(_loadTrips);
    on<AddTrip>(_addTrip);
    on<UpdateTrip>(_updateTrip);
    on<DeleteTrip>(_deleteTrip);
  }

  Future<void> _loadTrips(
      LoadTrips event,
      Emitter<TripState> emit,
      ) async {
    emit(const TripLoading());

    try {
      final response = await apiService.get(
        'https://jsonplaceholder.typicode.com/posts',
      );

      trips = (response as List).take(5).map((json) {
        return TripModel(
          id: json['id'],
          destination: 'Destination ${json['id']}',
          startDate: '2026-09-10',
          endDate: '2026-09-15',
        );
      }).toList();

      emit(TripLoaded(List.from(trips)));
    } catch (e) {
      emit(TripError(e.toString()));
    }
  }

  Future<void> _addTrip(
      AddTrip event,
      Emitter<TripState> emit,
      ) async {
    try {
      final response = await apiService.post(
        'https://jsonplaceholder.typicode.com/posts',
        event.trip.toJson(),
      );

      final newTrip = TripModel(
        id: response['id'] ?? 101,
        destination: event.trip.destination,
        startDate: event.trip.startDate,
        endDate: event.trip.endDate,
      );

      trips.add(newTrip);

      emit(const TripSuccess('Trip added successfully'));
      emit(TripLoaded(List.from(trips)));
    } catch (e) {
      emit(TripError(e.toString()));
    }
  }

  Future<void> _updateTrip(
      UpdateTrip event,
      Emitter<TripState> emit,
      ) async {
    try {
      await apiService.put(
        'https://jsonplaceholder.typicode.com/posts/${event.trip.id}',
        event.trip.toJson(),
      );

      final index = trips.indexWhere(
            (trip) => trip.id == event.trip.id,
      );

      if (index != -1) {
        trips[index] = event.trip;
      }

      emit(const TripSuccess('Trip updated successfully'));
      emit(TripLoaded(List.from(trips)));
    } catch (e) {
      emit(TripError(e.toString()));
    }
  }

  Future<void> _deleteTrip(
      DeleteTrip event,
      Emitter<TripState> emit,
      ) async {
    try {
      await apiService.delete(
        'https://jsonplaceholder.typicode.com/posts/${event.id}',
      );

      trips.removeWhere(
            (trip) => trip.id == event.id,
      );

      emit(const TripSuccess('Trip deleted successfully'));
      emit(TripLoaded(List.from(trips)));
    } catch (e) {
      emit(TripError(e.toString()));
    }
  }
}