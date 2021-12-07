import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/model/country.dart';

abstract class ContinentsState {
  bool isListenable() => false;
}

class ContinentsInitial extends ContinentsState {
  final bool isLoading;
  final List<CompleteCases> countryList;

  ContinentsInitial.initial()
      : isLoading = true,
        countryList = List.empty(),
        super();

  ContinentsInitial.loading({required this.countryList})
      : isLoading = true,
        super();

  ContinentsInitial.loaded({required this.countryList})
      : isLoading = false,
        super();
}

class ContinentsError extends ContinentsState {
  final String error;

  ContinentsError(this.error);

  @override
  bool isListenable() => true;
}
