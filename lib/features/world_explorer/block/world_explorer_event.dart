import 'package:equatable/equatable.dart';

class WorldExplorerEvent extends Equatable {
  const WorldExplorerEvent();

  @override
  List<Object?> get props => [];
}

class SearchCountry extends WorldExplorerEvent {
  final String country;

  const SearchCountry(this.country);

  @override
  List<Object?> get props => [country];
}