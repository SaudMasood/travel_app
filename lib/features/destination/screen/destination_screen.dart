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
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            country.name,
            style: AppTextStyles.heading3,
          ),
        ),
        body: BlocBuilder<DestinationBloc, DestinationState>(
          builder: (context, state) {
            if (state is DestinationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
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
                    // Country
                    Text(
                      country.flag,
                      style: const TextStyle(fontSize: 60),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      country.name,
                      style: AppTextStyles.heading1,
                    ),

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

                    const SizedBox(height: 25),

                    // Weather
                    Text(
                      'Weather',
                      style: AppTextStyles.heading2,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      '${state.weather.temperature} °C',
                      style: AppTextStyles.heading1,
                    ),

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

                    const SizedBox(height: 25),

                    // Air Quality
                    Text(
                      'Air Quality',
                      style: AppTextStyles.heading2,
                    ),

                    const SizedBox(height: 10),

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
                      'NO2: ${state.airQuality.nitrogenDioxide}',
                      style: AppTextStyles.body,
                    ),

                    Text(
                      'SO2: ${state.airQuality.sulphurDioxide}',
                      style: AppTextStyles.body,
                    ),

                    Text(
                      'Ozone: ${state.airQuality.ozone}',
                      style: AppTextStyles.body,
                    ),

                    const SizedBox(height: 25),

                    // Currency
                    Text(
                      'Currency Exchange',
                      style: AppTextStyles.heading2,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Base: ${country.currency}',
                      style: AppTextStyles.body,
                    ),

                    const SizedBox(height: 5),

                    if (state.currencies.isEmpty)
                      Text(
                        'No currency data available',
                        style: AppTextStyles.empty,
                      ),

                    for (final currency in state.currencies.take(10))
                      Text(
                        '${currency.quote}: ${currency.rate}',
                        style: AppTextStyles.body,
                      ),

                    const SizedBox(height: 25),

                    // News
                    Text(
                      'Latest News',
                      style: AppTextStyles.heading2,
                    ),

                    const SizedBox(height: 10),
                    if (state.news.isEmpty)
                      Text(
                        'No news available',
                        style: AppTextStyles.empty,
                      ),

                    for (final article in state.news)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (article.imageUrl.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  article.imageUrl,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return const SizedBox();
                                  },
                                ),
                              ),

                            const SizedBox(height: 8),

                            Text(
                              article.title,
                              style: AppTextStyles.heading3,
                            ),

                            const SizedBox(height: 5),

                            Text(
                              article.description,
                              style: AppTextStyles.bodySmall,
                            ),

                            const SizedBox(height: 5),

                            Text(
                              article.host,
                              style: AppTextStyles.bodySmall,
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