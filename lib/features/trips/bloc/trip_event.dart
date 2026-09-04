import 'package:equatable/equatable.dart';
import '../models/trip_model.dart';

abstract class TripEvent extends Equatable {
  const TripEvent();

  @override
  List<Object?> get props => [];
}

class LoadTrips extends TripEvent {
  const LoadTrips();
}

class AddTrip extends TripEvent {
  final TripModel trip;

  const AddTrip(this.trip);

  @override
  List<Object?> get props => [trip];
}

class UpdateTrip extends TripEvent {
  final TripModel trip;

  const UpdateTrip(this.trip);

  @override
  List<Object?> get props => [trip];
}

class DeleteTrip extends TripEvent {
  final int id;

  const DeleteTrip(this.id);

  @override
  List<Object?> get props => [id];
}