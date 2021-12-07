import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/model/country.dart';
import 'package:covid_tracker/common/getit_root.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cases_datasource.dart';

@Named(DatasourceKeys.local)
@Injectable(as: CasesDatasource)
class CasesLocalDatasource implements CasesDatasource {
  static const favoritesKey = "favorites";

  @override
  Future<List<CompleteCases>> getAllCasesByCountry() {
    // TODO: implement getAllCasesByCountry
    throw UnimplementedError();
  }

  @override
  Future<CompleteCases> getCasesByCountry(String country) {
    // TODO: implement getCasesByCountry
    throw UnimplementedError();
  }

  @override
  Future<List<CompleteCases>> getAllCasesByContinents(String continent) {
    // TODO: implement getAllCasesByContinents
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getFavoriteCountries() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(favoritesKey) ?? [];
  }

  @override
  Future<void> setFavoriteCountries(String favorite) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultList = preferences.getStringList(favoritesKey) ?? [];
    resultList.add(favorite);
    preferences.setStringList(favoritesKey, resultList);
  }

  @override
  Future<bool> getFavoriteCountryCheck(String favorite) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final result = preferences.getStringList(favoritesKey) ?? [];
    return result.contains(favorite);
  }

  @override
  Future<void> removeFavoriteCountry(String favorite) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final resultList = preferences.getStringList(favoritesKey) ?? [];
    resultList.remove(favorite);
    preferences.setStringList(favoritesKey, resultList);
  }
}
