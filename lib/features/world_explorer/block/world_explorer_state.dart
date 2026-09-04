import 'package:equatable/equatable.dart';

import '../models/country_info_model.dart';
import '../models/time_model.dart';
import '../models/population_model.dart';
import '../models/currency_model.dart';
import '../models/book_model.dart';

abstract class WorldExplorerState extends Equatable {
  const WorldExplorerState();

  @override
  List<Object?> get props => [];
}

class WorldExplorerInitial extends WorldExplorerState {
  const WorldExplorerInitial();
}

class WorldExplorerLoading extends WorldExplorerState {
  const WorldExplorerLoading();
}

class WorldExplorerLoaded extends WorldExplorerState {
  final CountryInfoModel country;
  final TimeModel time;
  final PopulationModel population;
  final String wikipedia;
  final List<CurrencyModel> currencies;
  final List<BookModel> books;

  const WorldExplorerLoaded({
    required this.country,
    required this.time,
    required this.population,
    required this.wikipedia,
    required this.currencies,
    required this.books,
  });

  @override
  List<Object?> get props => [
    country,
    time,
    population,
    wikipedia,
    currencies,
    books,
  ];
}

class WorldExplorerError extends WorldExplorerState {
  final String message;

  const WorldExplorerError(this.message);

  @override
  List<Object?> get props => [message];
}