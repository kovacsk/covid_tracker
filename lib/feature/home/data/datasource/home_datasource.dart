import '../../../../model/json_models.dart';

abstract class HomeDatasource{
  Future<Map<String, Country>> getAllCases();
  Future<Country> getCasesByCountry(String country);
  Future<Map<String, Vaccinated>> getAllVaccinated();
  Future<List<Country>> getFavoriteCountries();

}