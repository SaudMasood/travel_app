import 'package:equatable/equatable.dart';

import '../../home/models/country_model.dart';

abstract class DestinationEvent extends Equatable {
  const DestinationEvent();

  @override
  List<Object?> get props => [];
}

class LoadDestination extends DestinationEvent {
  final CountryModel country;

  const LoadDestination(this.country);

  @override
  List<Object?> get props => [country];
}