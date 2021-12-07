import 'package:covid_tracker/common/data/model/complete_cases.dart';

abstract class CasesDatasource {
  Future<List<CompleteCases>> getAllCasesByCountry();

  Future<List<CompleteCases>> getAllCasesByContinents(String continent);

  Future<CompleteCases> getCasesByCountry(String country);

  Future<List<String>> getFavoriteCountries();

  Future<void> setFavoriteCountries(String favorite);

  Future<void> removeFavoriteCountry(String favorite);

  Future<bool> getFavoriteCountryCheck(String favorite);
}
