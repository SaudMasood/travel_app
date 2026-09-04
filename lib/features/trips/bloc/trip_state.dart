import 'package:equatable/equatable.dart';
import '../models/trip_model.dart';

abstract class TripState extends Equatable {
  const TripState();

  @override
  List<Object?> get props => [];
}

class TripInitial extends TripState {
  const TripInitial();
}

class TripLoading extends TripState {
  const TripLoading();
}

class TripLoaded extends TripState {
  final List<TripModel> trips;

  const TripLoaded(this.trips);

  @override
  List<Object?> get props => [trips];
}

class TripSuccess extends TripState {
  final String message;

  const TripSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class TripError extends TripState {
  final String message;

  const TripError(this.message);

  @override
  List<Object?> get props => [message];
}