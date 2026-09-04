class CountryInfoModel {
  final String name;
  final String capital;
  final String region;
  final String flag;
  final String currency;
  final int population;
  final List<String> languages;
  final List<String> timezones;

  CountryInfoModel({
    required this.name,
    required this.capital,
    required this.region,
    required this.flag,
    required this.currency,
    required this.population,
    required this.languages,
    required this.timezones,
  });

  factory CountryInfoModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final List languagesData =
        json['languages'] ?? [];

    final List<String> languages = [];

    for (final language in languagesData) {
      languages.add(
        language['name'] ?? '',
      );
    }

    final List timezonesData =
        json['timezones'] ?? [];

    final List<String> timezones = [];

    for (final timezone in timezonesData) {
      timezones.add(
        timezone.toString(),
      );
    }

    final List currencies =
        json['currencies'] ?? [];

    String currency = '';

    if (currencies.isNotEmpty) {
      currency = currencies[0]['code'] ?? '';
    }

    return CountryInfoModel(
      name: json['name'] ?? '',
      capital: json['capital'] ?? 'No capital',
      region: json['region'] ?? '',
      flag: json['flags']?['png'] ?? '',
      currency: currency,
      population: json['population'] ?? 0,
      languages: languages,
      timezones: timezones,
    );
  }
}