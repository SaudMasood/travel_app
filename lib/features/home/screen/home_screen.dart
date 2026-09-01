import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/api_constants.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../destination/screen/destination_screen.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController =
  TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchCountry() {
    final country = searchController.text.trim();

    if (country.isEmpty) {
      return;
    }

    context.read<HomeBloc>().add(
      SearchCountry(country),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text(
          AppConstants.appName,
          style: AppTextStyles.heading3,
        ),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Explore the World',
              style: AppTextStyles.heading1,
            ),

            const SizedBox(height: 8),


            Text(
              'Search for a country and discover more.',
              style: AppTextStyles.bodySmall,
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: AppTextStyles.input,

                    decoration: InputDecoration(
                      hintText: 'Search country...',
                      hintStyle: AppTextStyles.bodySmall,

                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.grey,
                      ),

                      filled: true,
                      fillColor: AppColors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),

                    onSubmitted: (_) {
                      searchCountry();
                    },
                  ),
                ),

                const SizedBox(width: 10),

                // Search Button
                ElevatedButton(
                  onPressed: searchCountry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Search',
                    style: AppTextStyles.button,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Results
            Text(
              'Search Results',
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 12),

            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {

                  if (state is HomeInitial) {
                    return Center(
                      child: Text(
                        'Search for a country',
                        style: AppTextStyles.empty,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }


                  if (state is HomeLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  // Error
                  if (state is HomeError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: AppTextStyles.error,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  if (state is HomeLoaded) {

                    if (state.countries.isEmpty) {
                      return Center(
                        child: Text(
                          'No country found.',
                          style: AppTextStyles.empty,
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: state.countries.length,

                      itemBuilder: (context, index) {
                        final country =
                        state.countries[index];

                        return Card(
                          color: AppColors.white,
                          elevation: 1,
                          margin: const EdgeInsets.only(
                            bottom: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                          ),

                          child: ListTile(
                            contentPadding:
                            const EdgeInsets.all(12),

                            leading: Text(
                              country.flag,
                              style: const TextStyle(
                                fontSize: 35,
                              ),
                            ),

                            title: Text(
                              country.name,
                              style: AppTextStyles.heading3,
                            ),

                            subtitle: Padding(
                              padding:
                              const EdgeInsets.only(
                                top: 4,
                              ),
                              child: Text(
                                '${country.capital} • ${country.region}',
                                style:
                                AppTextStyles.bodySmall,
                              ),
                            ),

                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: AppColors.grey,
                            ),

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DestinationScreen(
                                    country: country,
                                  ),
                                ),
                              );
                            },
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
    );
  }
}