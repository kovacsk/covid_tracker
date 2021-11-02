import 'package:covid_tracker/common/network/api/covid_cases_api.dart';
import 'package:covid_tracker/common/network/api/covid_vaccines_api.dart';
import 'package:covid_tracker/feature/home/data/datasource/home_datasource.dart';
import 'package:covid_tracker/model/json_models.dart';

class HomeRemoteDatasource implements HomeDatasource {
  final CovidCasesApi _covidCasesApi;
  final CovidVaccinesApi _covidVaccinesApi;

  HomeRemoteDatasource(this._covidCasesApi, this._covidVaccinesApi);

  @override
  Future<Map<String, Country>> getAllCases() async {
    return _covidCasesApi.getAllCases();
  }

  @override
  Future<Map<String, Vaccinated>> getAllVaccinated() async {
    return _covidVaccinesApi.getAllVaccinated();
  }

  @override
  Future<Country> getCasesByCountry(String country) async {
    return _covidCasesApi.getCasesByCountry(country);
  }

  @override
  Future<List<Country>> getFavoriteCountries() {
    // TODO: implement getFavoriteCountries
    throw UnimplementedError();
  }
}
