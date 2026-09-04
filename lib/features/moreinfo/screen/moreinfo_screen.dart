import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../block/moreinfo_bloc.dart';
import '../block/moreinfo_event.dart';
import '../block/moreinfo_state.dart';

class MoreInfoScreen extends StatelessWidget {
  final String countryCode;
  final String city;
  final double latitude;
  final double longitude;

  const MoreInfoScreen({
    super.key,
    required this.countryCode,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    context.read<MoreInfoBloc>().add(
      LoadMoreInfo(
        countryCode: countryCode,
        city: city,
        latitude: latitude,
        longitude: longitude,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),

      appBar: AppBar(
        backgroundColor: const Color(0xFF172554),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'More Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: BlocBuilder<MoreInfoBloc, MoreInfoState>(
        builder: (context, state) {
          if (state is MoreInfoLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4F46E5),
              ),
            );
          }

          if (state is MoreInfoError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  state.message,
                  style: AppTextStyles.error,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (state is MoreInfoLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Public Holidays',
                  style: AppTextStyles.heading2.copyWith(
                    color: const Color(0xFF172554),
                  ),
                ),

                const SizedBox(height: 10),

                for (final holiday in state.holidays.take(5))
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.event,
                          color: Color(0xFF4F46E5),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                holiday.localName,
                                style: AppTextStyles.heading3,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                holiday.date,
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 18),

                Text(
                  'Sunrise & Sunset',
                  style: AppTextStyles.heading2.copyWith(
                    color: const Color(0xFF172554),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F7FA),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.wb_sunny,
                            color: Color(0xFF0891B2),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Sunrise',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(state.sunrise.sunrise),
                        ],
                      ),

                      const SizedBox(height: 14),

                      Row(
                        children: [
                          const Icon(
                            Icons.nights_stay,
                            color: Color(0xFF4F46E5),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Sunset',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(state.sunrise.sunset),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  'Location',
                  style: AppTextStyles.heading2.copyWith(
                    color: const Color(0xFF172554),
                  ),
                ),

                const SizedBox(height: 10),

                for (final location in state.locations.take(3))
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF0891B2),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                location.displayName,
                                style: AppTextStyles.body,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${location.latitude}, ${location.longitude}',
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 18),

                Text(
                  'Elevation',
                  style: AppTextStyles.heading2.copyWith(
                    color: const Color(0xFF172554),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.terrain,
                        color: Color(0xFF4F46E5),
                        size: 30,
                      ),

                      const SizedBox(width: 12),

                      const Text(
                        'Elevation',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      Text(
                        '${state.elevation.elevation} m',
                        style: const TextStyle(
                          color: Color(0xFF0891B2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  'About $city',
                  style: AppTextStyles.heading2.copyWith(
                    color: const Color(0xFF172554),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.wikipedia.title,
                        style: AppTextStyles.heading3.copyWith(
                          color: const Color(0xFF172554),
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        state.wikipedia.description,
                        style: AppTextStyles.bodySmall,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        state.wikipedia.extract,
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  'Travel Books',
                  style: AppTextStyles.heading2.copyWith(
                    color: const Color(0xFF172554),
                  ),
                ),

                const SizedBox(height: 10),

                for (final book in state.books.take(5))
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.book,
                          color: Color(0xFF4F46E5),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style: AppTextStyles.heading3,
                              ),

                              const SizedBox(height: 4),

                              Text(
                                '${book.author} • ${book.year}',
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }

          return const Center(
            child: Text('No information available'),
          );
        },
      ),
    );
  }
}