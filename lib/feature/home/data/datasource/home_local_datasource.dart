import 'package:covid_tracker/feature/home/data/datasource/home_datasource.dart';
import 'package:covid_tracker/model/json_models.dart';

class HomeLocalDatasource implements HomeDatasource{
  @override
  Future<Map<String, Country>> getAllCases() {
    // TODO: implement getAllCases
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Vaccinated>> getAllVaccinated() {
    // TODO: implement getAllVaccinated
    throw UnimplementedError();
  }

  @override
  Future<Country> getCasesByCountry(String country) {
    // TODO: implement getCasesByCountry
    throw UnimplementedError();
  }

  @override
  Future<List<Country>> getFavoriteCountries() {
    // TODO: implement getFavoriteCountries
    throw UnimplementedError();
  }

}