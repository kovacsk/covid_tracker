import 'package:covid_tracker/feature/home/data/datasource/home_local_datasource.dart';
import 'package:covid_tracker/feature/home/data/datasource/home_remote_datasource.dart';

import '../../../../model/json_models.dart';

abstract class HomeRepository {
  Future<Map<String, Country>> getAllCases();

  Future<Country> getCasesByCountry(String country);

  Future<Map<String, Vaccinated>> getAllVaccinated();

  Future<List<Country>> getFavoriteCountries();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDatasource _homeLocalDatasource;
  final HomeRemoteDatasource _homeRemoteDatasource;

  HomeRepositoryImpl(this._homeRemoteDatasource, this._homeLocalDatasource);

  @override
  Future<Map<String, Country>> getAllCases() async {
    return _homeRemoteDatasource.getAllCases();
  }

  @override
  Future<Map<String, Vaccinated>> getAllVaccinated() async {
    return _homeRemoteDatasource.getAllVaccinated();
  }

  @override
  Future<Country> getCasesByCountry(String country) async {
    return _homeRemoteDatasource.getCasesByCountry(country);
  }

  @override
  Future<List<Country>> getFavoriteCountries() async {
    return _homeLocalDatasource.getFavoriteCountries();
  }
}
