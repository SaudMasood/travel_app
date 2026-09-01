

import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{

}
class SearchCountry extends HomeEvent {
  final String countrycode;

  SearchCountry(this.countrycode);

  @override
  // TODO: implement props
  List<Object?> get props => [countrycode];

}