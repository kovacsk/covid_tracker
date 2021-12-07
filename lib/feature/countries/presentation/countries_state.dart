import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/model/country.dart';

abstract class CountriesState {
  bool isListenable() => false;
}

class CountriesInitial extends CountriesState {
  final bool isLoading;
  final List<CompleteCases> countryList;

  CountriesInitial.initial()
      : isLoading = true,
        countryList = List.empty(),
        super();

  CountriesInitial.loading({required this.countryList})
      : isLoading = true,
        super();

  CountriesInitial.loaded({required this.countryList})
      : isLoading = false,
        super();
}

class CountriesError extends CountriesState {
  final String error;

  CountriesError(this.error);

  @override
  bool isListenable() => true;
}
