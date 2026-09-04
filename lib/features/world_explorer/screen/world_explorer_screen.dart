import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

import '../block/world_explorer_bloc.dart';
import '../block/world_explorer_event.dart';
import '../block/world_explorer_state.dart';

class WorldExplorerScreen extends StatefulWidget {
  const WorldExplorerScreen({super.key});

  @override
  State<WorldExplorerScreen> createState() =>
      _WorldExplorerScreenState();
}

class _WorldExplorerScreenState
    extends State<WorldExplorerScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),

      appBar: AppBar(
        title: const Text(
          'World Explorer',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF172554),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: BlocBuilder<WorldExplorerBloc, WorldExplorerState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Explore the World',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172554),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Search a country and discover useful information.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF06B6D4),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Color(0xFF4F46E5),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Enter country name',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) {
                          if (searchController.text
                              .trim()
                              .isNotEmpty) {
                            context
                                .read<WorldExplorerBloc>()
                                .add(
                              SearchCountry(
                                searchController.text.trim(),
                              ),
                            );
                          }
                        },
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        if (searchController.text
                            .trim()
                            .isNotEmpty) {
                          context
                              .read<WorldExplorerBloc>()
                              .add(
                            SearchCountry(
                              searchController.text.trim(),
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF0891B2),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              if (state is WorldExplorerInitial)
                const Center(
                  child: Text(
                    'Search a country',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),

              if (state is WorldExplorerLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF4F46E5),
                  ),
                ),

              if (state is WorldExplorerError)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    state.message,
                    style: AppTextStyles.error,
                    textAlign: TextAlign.center,
                  ),
                ),

              if (state is WorldExplorerLoaded) ...[
                Text(
                  'Country Information',
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
                      if (state.country.flag.isNotEmpty)
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(10),
                          child: Image.network(
                            state.country.flag,
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stack) {
                              return Container(
                                height: 130,
                                color: const Color(0xFFE0F7FA),
                                child: const Center(
                                  child: Icon(
                                    Icons.flag,
                                    size: 50,
                                    color: Color(0xFF0891B2),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                      const SizedBox(height: 15),

                      Text(
                        state.country.name,
                        style: AppTextStyles.heading2.copyWith(
                          color: const Color(0xFF172554),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Capital: ${state.country.capital}',
                        style: AppTextStyles.body,
                      ),

                      Text(
                        'Region: ${state.country.region}',
                        style: AppTextStyles.body,
                      ),

                      Text(
                        'Currency: ${state.country.currency}',
                        style: AppTextStyles.body,
                      ),

                      Text(
                        'Population: ${state.country.population}',
                        style: AppTextStyles.body,
                      ),

                      Text(
                        'Languages: '
                            '${state.country.languages.join(', ')}',
                        style: AppTextStyles.body,
                      ),

                      Text(
                        'Timezone: '
                            '${state.country.timezones.join(', ')}',
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

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
                          const SizedBox(width: 10),
                          const Text('Sunrise'),
                          const Spacer(),
                          Text(state.time.sunrise),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Icon(
                            Icons.nights_stay,
                            color: Color(0xFF4F46E5),
                          ),
                          const SizedBox(width: 10),
                          const Text('Sunset'),
                          const Spacer(),
                          Text(state.time.sunset),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Icon(
                            Icons.wb_twilight,
                            color: Color(0xFF0891B2),
                          ),
                          const SizedBox(width: 10),
                          const Text('Dawn'),
                          const Spacer(),
                          Text(state.time.dawn),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Icon(
                            Icons.brightness_3,
                            color: Color(0xFF4F46E5),
                          ),
                          const SizedBox(width: 10),
                          const Text('Dusk'),
                          const Spacer(),
                          Text(state.time.dusk),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Population',
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
                        'Country: '
                            '${state.population.country}',
                        style: AppTextStyles.body,
                      ),

                      Text(
                        'Population: '
                            '${state.population.population}',
                        style: AppTextStyles.body,
                      ),

                      Text(
                        'Year: ${state.population.year}',
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'About Country',
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
                  child: Text(
                    state.wikipedia.isNotEmpty
                        ? state.wikipedia
                        : 'No information available.',
                    style: AppTextStyles.body,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Currency Rates',
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
                      if (state.currencies.isEmpty)
                        const Text(
                          'No currency rates available.',
                        ),

                      for (var currency in state.currencies)
                        Padding(
                          padding:
                          const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '${currency.base} → '
                                '${currency.quote}: '
                                '${currency.rate}',
                            style: AppTextStyles.body,
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Travel Books',
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
                      if (state.books.isEmpty)
                        const Text(
                          'No books available.',
                        ),

                      for (var book in state.books)
                        Padding(
                          padding:
                          const EdgeInsets.only(bottom: 14),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style:
                                AppTextStyles.heading3.copyWith(
                                  color:
                                  const Color(0xFF172554),
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                'Author: ${book.author}',
                                style:
                                AppTextStyles.bodySmall,
                              ),

                              Text(
                                'Year: ${book.year}',
                                style:
                                AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}