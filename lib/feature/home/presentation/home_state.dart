import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/model/country.dart';
import 'package:covid_tracker/common/data/model/vaccinated.dart';

abstract class HomeState {
  bool isListenable() => false;
}

class HomeInitial extends HomeState {
  final bool isLoading;
  final List<CompleteCases> favoriteCountries;
  final double vaccinatedPercentage;
  final CompleteCases country;
  final double casesPercentage;

  HomeInitial.initial()
      : isLoading = true,
        country = CompleteCases.empty,
        favoriteCountries = List.empty(),
        vaccinatedPercentage = 0.0,
        casesPercentage = 0.0,
        super();

  HomeInitial.loading(
      {required this.country,
      required this.vaccinatedPercentage,
      required this.casesPercentage,
      required this.favoriteCountries})
      : isLoading = true,
        super();

  HomeInitial.loaded(
      {required this.country,
      required this.vaccinatedPercentage,
      required this.casesPercentage,
      required this.favoriteCountries})
      : isLoading = false,
        super();
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);

  @override
  bool isListenable() => true;
}
