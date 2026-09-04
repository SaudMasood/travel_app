import 'package:equatable/equatable.dart';

import '../models/travelnotemodel.dart';


abstract class TravelNotesState extends Equatable {
  const TravelNotesState();

  @override
  List<Object?> get props => [];
}

class TravelNotesInitial extends TravelNotesState {
  const TravelNotesInitial();
}

class TravelNotesLoading extends TravelNotesState {
  const TravelNotesLoading();
}

class TravelNotesLoaded extends TravelNotesState {
  final List<TravelNoteModel> notes;

  const TravelNotesLoaded(this.notes);

  @override
  List<Object?> get props => [notes];
}

class TravelNotesSuccess extends TravelNotesState {
  final String message;

  const TravelNotesSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class TravelNotesError extends TravelNotesState {
  final String message;

  const TravelNotesError(this.message);

  @override
  List<Object?> get props => [message];
}