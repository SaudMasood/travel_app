import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/trip_bloc.dart';
import '../bloc/trip_event.dart';
import '../bloc/trip_state.dart';
import '../models/trip_model.dart';

class AddEditTripScreen extends StatefulWidget {
  final TripModel? trip;

  const AddEditTripScreen({
    super.key,
    this.trip,
  });

  @override
  State<AddEditTripScreen> createState() => _AddEditTripScreenState();
}

class _AddEditTripScreenState extends State<AddEditTripScreen> {
  final destinationController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.trip != null) {
      destinationController.text = widget.trip!.destination;
      startDateController.text = widget.trip!.startDate;
      endDateController.text = widget.trip!.endDate;
    }
  }

  @override
  void dispose() {
    destinationController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.trip != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),

      appBar: AppBar(
        title: Text(isEditing ? 'Edit Trip' : 'Add Trip'),
        backgroundColor: const Color(0xFF172554),
        foregroundColor: Colors.white,
      ),

      body: BlocListener<TripBloc, TripState>(
        listener: (context, state) {
          if (state is TripSuccess) {
            Navigator.pop(context);
          }

          if (state is TripError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                'Plan Your Trip',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172554),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Enter your trip details below.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Destination',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172554),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: destinationController,
                decoration: InputDecoration(
                  hintText: 'Enter destination',
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF0891B2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Start Date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172554),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: startDateController,
                decoration: InputDecoration(
                  hintText: 'YYYY-MM-DD',
                  prefixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xFF4F46E5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'End Date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172554),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: endDateController,
                decoration: InputDecoration(
                  hintText: 'YYYY-MM-DD',
                  prefixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xFF4F46E5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(
                  onPressed: () {
                    if (destinationController.text.trim().isEmpty ||
                        startDateController.text.trim().isEmpty ||
                        endDateController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all fields'),
                        ),
                      );
                      return;
                    }

                    final trip = TripModel(
                      id: widget.trip?.id ?? 0,
                      destination: destinationController.text.trim(),
                      startDate: startDateController.text.trim(),
                      endDate: endDateController.text.trim(),
                    );

                    if (isEditing) {
                      context.read<TripBloc>().add(
                        UpdateTrip(trip),
                      );
                    } else {
                      context.read<TripBloc>().add(
                        AddTrip(trip),
                      );
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: Text(
                    isEditing ? 'Update Trip' : 'Add Trip',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}