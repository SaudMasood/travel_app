import 'package:equatable/equatable.dart';

import '../models/travelnotemodel.dart';


abstract class TravelNotesEvent extends Equatable {
  const TravelNotesEvent();

  @override
  List<Object?> get props => [];
}

class LoadTravelNotes extends TravelNotesEvent {
  const LoadTravelNotes();
}

class AddTravelNote extends TravelNotesEvent {
  final TravelNoteModel note;

  const AddTravelNote(this.note);

  @override
  List<Object?> get props => [note];
}

class UpdateTravelNote extends TravelNotesEvent {
  final TravelNoteModel note;

  const UpdateTravelNote(this.note);

  @override
  List<Object?> get props => [note];
}

class DeleteTravelNote extends TravelNotesEvent {
  final int id;

  const DeleteTravelNote(this.id);

  @override
  List<Object?> get props => [id];
}