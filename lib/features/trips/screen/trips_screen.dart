import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/trip_bloc.dart';
import '../bloc/trip_event.dart';
import '../bloc/trip_state.dart';
import 'add_edit_trip_screen.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),

      appBar: AppBar(
        title: const Text(
          'My Trips',
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditTripScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: BlocListener<TripBloc, TripState>(
        listener: (context, state) {
          if (state is TripSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }

          if (state is TripError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },

        child: BlocBuilder<TripBloc, TripState>(
          builder: (context, state) {
            if (state is TripLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF4F46E5),
                ),
              );
            }

            if (state is TripError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              );
            }

            if (state is TripLoaded) {
              if (state.trips.isEmpty) {
                return const Center(
                  child: Text(
                    'No trips available',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.trips.length,

                itemBuilder: (context, index) {
                  final trip = state.trips[index];

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
                              Icons.flight,
                              color: Color(0xFF0891B2),
                              size: 28,
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                trip.destination,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF172554),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Text(
                          'Start Date: ${trip.startDate}',
                          style: const TextStyle(
                            color: Color(0xFF475569),
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          'End Date: ${trip.endDate}',
                          style: const TextStyle(
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        AddEditTripScreen(
                                          trip: trip,
                                        ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color(0xFF4F46E5),
                                foregroundColor: Colors.white,
                              ),
                              icon: const Icon(
                                Icons.edit,
                                size: 17,
                              ),
                              label: const Text('Edit'),
                            ),

                            const SizedBox(width: 8),

                            ElevatedButton.icon(
                              onPressed: () {
                                context
                                    .read<TripBloc>()
                                    .add(
                                  DeleteTrip(trip.id),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              icon: const Icon(
                                Icons.delete,
                                size: 17,
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
              child: Text('No trips'),
            );
          },
        ),
      ),
    );
  }
}