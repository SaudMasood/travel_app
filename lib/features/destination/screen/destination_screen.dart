import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/api_service.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

import '../../home/models/country_model.dart';
import '../bloc/destination_bloc.dart';
import '../bloc/destination_event.dart';
import '../bloc/destination_state.dart';

class DestinationScreen extends StatelessWidget {
  final CountryModel country;

  const DestinationScreen({
    super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DestinationBloc(ApiService())
        ..add(LoadDestination(country)),
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7FC),
        appBar: AppBar(
          backgroundColor: const Color(0xFF172554),
          foregroundColor: Colors.white,
          title: Text(
            country.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<DestinationBloc, DestinationState>(
          builder: (context, state) {
            if (state is DestinationLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF4F46E5),
                ),
              );
            }

            if (state is DestinationError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    state.message,
                    style: AppTextStyles.error,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (state is DestinationLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF172554),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Text(
                            country.flag,
                            style: const TextStyle(
                              fontSize: 65,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            country.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            country.capital,
                            style: const TextStyle(
                              color: Color(0xFF67E8F9),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Country Information',
                      style: AppTextStyles.heading2.copyWith(
                        color: const Color(0xFF172554),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
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
                            'Capital: ${country.capital}',
                            style: AppTextStyles.body,
                          ),
                          Text(
                            'Region: ${country.region}',
                            style: AppTextStyles.body,
                          ),
                          Text(
                            'Population: ${country.population}',
                            style: AppTextStyles.body,
                          ),
                          Text(
                            'Currency: ${country.currency}',
                            style: AppTextStyles.body,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Weather',
                      style: AppTextStyles.heading2.copyWith(
                        color: const Color(0xFF172554),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F7FA),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.weather.temperature} °C',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF172554),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Humidity: ${state.weather.humidity}%',
                            style: AppTextStyles.body,
                          ),

                          Text(
                            'Feels Like: ${state.weather.apparentTemperature} °C',
                            style: AppTextStyles.body,
                          ),

                          Text(
                            'Wind: ${state.weather.windSpeed} km/h',
                            style: AppTextStyles.body,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Air Quality',
                      style: AppTextStyles.heading2.copyWith(
                        color: const Color(0xFF172554),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
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
                            'PM2.5: ${state.airQuality.pm2_5}',
                            style: AppTextStyles.body,
                          ),
                          Text(
                            'PM10: ${state.airQuality.pm10}',
                            style: AppTextStyles.body,
                          ),
                          Text(
                            'CO: ${state.airQuality.carbonMonoxide}',
                            style: AppTextStyles.body,
                          ),
                          Text(
                            'NO₂: ${state.airQuality.nitrogenDioxide}',
                            style: AppTextStyles.body,
                          ),
                          Text(
                            'SO₂: ${state.airQuality.sulphurDioxide}',
                            style: AppTextStyles.body,
                          ),
                          Text(
                            'Ozone: ${state.airQuality.ozone}',
                            style: AppTextStyles.body,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Currency Exchange',
                      style: AppTextStyles.heading2.copyWith(
                        color: const Color(0xFF172554),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
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
                            'Base: ${country.currency}',
                            style: const TextStyle(
                              color: Color(0xFF0891B2),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          if (state.currencies.isEmpty)
                            Text(
                              'No currency data available',
                              style: AppTextStyles.empty,
                            ),

                          for (final currency
                          in state.currencies.take(10))
                            Text(
                              '${currency.quote}: ${currency.rate}',
                              style: AppTextStyles.body,
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Latest News',
                      style: AppTextStyles.heading2.copyWith(
                        color: const Color(0xFF172554),
                      ),
                    ),

                    const SizedBox(height: 10),

                    if (state.news.isEmpty)
                      Text(
                        'No news available',
                        style: AppTextStyles.empty,
                      ),

                    for (final article in state.news)
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 16,
                        ),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            if (article.imageUrl.isNotEmpty)
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10),
                                child: Image.network(
                                  article.imageUrl,
                                  height: 170,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stack) {
                                    return Container(
                                      height: 170,
                                      color:
                                      const Color(0xFFE0F7FA),
                                      child: const Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 45,
                                          color:
                                          Color(0xFF0891B2),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                            const SizedBox(height: 10),

                            Text(
                              article.title,
                              style:
                              AppTextStyles.heading3.copyWith(
                                color:
                                const Color(0xFF172554),
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              article.description,
                              style:
                              AppTextStyles.bodySmall,
                            ),

                            const SizedBox(height: 6),

                            Text(
                              article.host,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF0891B2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}