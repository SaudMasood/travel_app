import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/api_constants.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../../destination/screen/destination_screen.dart';
import '../../moreinfo/screen/moreinfo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

  void searchCountry() {
    if (searchController.text.trim().isNotEmpty) {
      context.read<HomeBloc>().add(
        SearchCountry(searchController.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF172554),

      appBar: AppBar(
        title: Text(
          AppConstants.appName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF172554),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Container(

             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24))
             ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Explore the World',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF172554),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Search a country to discover travel information.',
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onSubmitted: (_) => searchCountry(),
                            decoration: InputDecoration(
                              hintText: 'Country code e.g. PK',
                              prefixIcon: const Icon(
                                Icons.search,
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
                        ),

                        const SizedBox(width: 8),

                        ElevatedButton(
                          onPressed: searchCountry,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F46E5),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 17,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Search'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Search Results',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF172554),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeInitial) {
                      return const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.travel_explore,
                              size: 60,
                              color: Color(0xFF06B6D4),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Search for a country',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is HomeLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF4F46E5),
                        ),
                      );
                    }

                    if (state is HomeError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    if (state is HomeLoaded) {
                      if (state.countries.isEmpty) {
                        return const Center(
                          child: Text('No country found.'),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: state.countries.length,
                        itemBuilder: (context, index) {
                          final country = state.countries[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFE0E7FF),
                              ),
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE0F7FA),
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        country.flag,
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            country.name,
                                            style: const TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF172554),
                                            ),
                                          ),

                                          const SizedBox(height: 4),

                                          Text(
                                            country.capital,
                                            style: const TextStyle(
                                              color: Color(0xFF64748B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  'Region: ${country.region}',
                                  style: const TextStyle(
                                    color: Color(0xFF475569),
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  'Population: ${country.population}',
                                  style: const TextStyle(
                                    color: Color(0xFF475569),
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  'Currency: ${country.currency}',
                                  style: const TextStyle(
                                    color: Color(0xFF475569),
                                  ),
                                ),

                                const SizedBox(height: 15),

                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              DestinationScreen(
                                                country: country,
                                              ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color(0xFF4F46E5),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.all(13),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Explore Destination',
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 8),

                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              MoreInfoScreen(
                                                countryCode:
                                                searchController.text
                                                    .trim()
                                                    .toUpperCase(),
                                                city: country.capital,
                                                latitude: country.latitude,
                                                longitude: country.longitude,
                                              ),
                                        ),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor:
                                      const Color(0xFF0891B2),
                                      side: const BorderSide(
                                        color: Color(0xFF06B6D4),
                                      ),
                                      padding: const EdgeInsets.all(13),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text('More Info'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}