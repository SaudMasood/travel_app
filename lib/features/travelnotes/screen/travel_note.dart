import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../block/travel_notes_bloc.dart';
import '../block/travel_notes_event.dart';
import '../block/travel_notes_state.dart';
import '../models/travelnotemodel.dart';

class TravelNotesScreen extends StatefulWidget {
  const TravelNotesScreen({super.key});

  @override
  State<TravelNotesScreen> createState() => _TravelNotesScreenState();
}

class _TravelNotesScreenState extends State<TravelNotesScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),

      appBar: AppBar(
        title: const Text(
          'Travel Notes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF172554),
        foregroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          titleController.clear();
          bodyController.clear();

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Travel Note'),

                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        prefixIcon: Icon(Icons.title),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: bodyController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Note',
                        prefixIcon: Icon(Icons.edit_note),
                      ),
                    ),
                  ],
                ),

                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (titleController.text.trim().isEmpty ||
                          bodyController.text.trim().isEmpty) {
                        return;
                      }

                      context.read<TravelNotesBloc>().add(
                        AddTravelNote(
                          TravelNoteModel(
                            id: 0,
                            title: titleController.text.trim(),
                            body: bodyController.text.trim(),
                          ),
                        ),
                      );

                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
      ),

      body: BlocBuilder<TravelNotesBloc, TravelNotesState>(
        builder: (context, state) {
          if (state is TravelNotesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4F46E5),
              ),
            );
          }

          if (state is TravelNotesError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is TravelNotesLoaded) {
            if (state.notes.isEmpty) {
              return const Center(
                child: Text(
                  'No travel notes yet',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFE0E7FF),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.note_alt,
                            color: Color(0xFF06B6D4),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: Text(
                              note.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF172554),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        note.body,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF475569),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              titleController.text = note.title;
                              bodyController.text = note.body;

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Edit Note'),

                                    content: Column(
                                      mainAxisSize:
                                      MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller:
                                          titleController,
                                          decoration:
                                          const InputDecoration(
                                            labelText: 'Title',
                                            prefixIcon:
                                            Icon(Icons.title),
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        TextField(
                                          controller:
                                          bodyController,
                                          maxLines: 4,
                                          decoration:
                                          const InputDecoration(
                                            labelText: 'Note',
                                            prefixIcon: Icon(
                                              Icons.edit_note,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child:
                                        const Text('Cancel'),
                                      ),

                                      ElevatedButton(
                                        style:
                                        ElevatedButton.styleFrom(
                                          backgroundColor:
                                          const Color(
                                              0xFF4F46E5),
                                          foregroundColor:
                                          Colors.white,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<
                                              TravelNotesBloc>()
                                              .add(
                                            UpdateTravelNote(
                                              TravelNoteModel(
                                                id: note.id,
                                                title:
                                                titleController
                                                    .text
                                                    .trim(),
                                                body:
                                                bodyController
                                                    .text
                                                    .trim(),
                                              ),
                                            ),
                                          );

                                          Navigator.pop(context);
                                        },
                                        child:
                                        const Text('Update'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color(0xFF4F46E5),
                              foregroundColor: Colors.white,
                            ),
                            icon: const Icon(
                              Icons.edit,
                              size: 18,
                            ),
                            label: const Text('Edit'),
                          ),

                          const SizedBox(width: 8),

                          ElevatedButton.icon(
                            onPressed: () {
                              context
                                  .read<TravelNotesBloc>()
                                  .add(
                                DeleteTravelNote(note.id),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            icon: const Icon(
                              Icons.delete,
                              size: 18,
                            ),
                            label: const Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text('No travel notes'),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }
}