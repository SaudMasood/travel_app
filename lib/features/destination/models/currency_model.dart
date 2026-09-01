class CurrencyModel {
  final String date;
  final String base;
  final String quote;
  final double rate;

  CurrencyModel({
    required this.date,
    required this.base,
    required this.quote,
    required this.rate,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      date: json['date'] ?? '',
      base: json['base'] ?? '',
      quote: json['quote'] ?? '',
      rate: (json['rate'] as num).toDouble(),
    );
  }
}