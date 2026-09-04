import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/api_service.dart';

import '../models/travelnotemodel.dart';
import 'travel_notes_event.dart';
import 'travel_notes_state.dart';

class TravelNotesBloc
    extends Bloc<TravelNotesEvent, TravelNotesState> {

  final ApiService apiService;

  List<TravelNoteModel> notes = [];

  TravelNotesBloc(this.apiService)
      : super(const TravelNotesInitial()) {

    on<LoadTravelNotes>(_loadTravelNotes);
    on<AddTravelNote>(_addTravelNote);
    on<UpdateTravelNote>(_updateTravelNote);
    on<DeleteTravelNote>(_deleteTravelNote);
  }

  Future<void> _loadTravelNotes(
      LoadTravelNotes event,
      Emitter<TravelNotesState> emit,
      ) async {

    emit(const TravelNotesLoading());

    try {

      final response = await apiService.get(
        'https://dummyjson.com/posts',
      );

      final List data = response['posts'];

      notes = data
          .take(10)
          .map(
            (json) => TravelNoteModel.fromJson(json),
      )
          .toList();

      emit(
        TravelNotesLoaded(
          List.from(notes),
        ),
      );

    } catch (e) {

      emit(
        TravelNotesError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _addTravelNote(
      AddTravelNote event,
      Emitter<TravelNotesState> emit,
      ) async {
    try {
      await apiService.post(
        'https://dummyjson.com/posts/add',
        event.note.toJson(),
      );

      final newNote = TravelNoteModel(
        id: notes.length + 1,
        title: event.note.title,
        body: event.note.body,
      );

      notes.insert(0, newNote);

      emit(
        const TravelNotesSuccess(
          'Note added successfully',
        ),
      );

      emit(
        TravelNotesLoaded(
          List.from(notes),
        ),
      );
    } catch (e) {
      emit(
        TravelNotesError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _updateTravelNote(
      UpdateTravelNote event,
      Emitter<TravelNotesState> emit,
      ) async {

    try {

      print('Updating note ID: ${event.note.id}');

      await apiService.put(
        'https://dummyjson.com/posts/${event.note.id}',
        event.note.toJson(),
      );

      final index = notes.indexWhere(
            (note) => note.id == event.note.id,
      );

      if (index != -1) {

        notes[index] = event.note;

      }

      emit(
        const TravelNotesSuccess(
          'Note updated successfully',
        ),
      );

      emit(
        TravelNotesLoaded(
          List.from(notes),
        ),
      );

    } catch (e) {

      print('Update Error: $e');

      emit(
        TravelNotesError(
          'Update failed: $e',
        ),
      );
    }
  }

  Future<void> _deleteTravelNote(
      DeleteTravelNote event,
      Emitter<TravelNotesState> emit,
      ) async {

    try {

      print('Deleting note ID: ${event.id}');

      await apiService.delete(
        'https://dummyjson.com/posts/${event.id}',
      );

      notes.removeWhere(
            (note) => note.id == event.id,
      );

      emit(
        const TravelNotesSuccess(
          'Note deleted successfully',
        ),
      );

      emit(
        TravelNotesLoaded(
          List.from(notes),
        ),
      );

    } catch (e) {

      print('Delete Error: $e');

      emit(
        TravelNotesError(
          'Delete failed: $e',
        ),
      );
    }
  }
}