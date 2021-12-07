import 'package:covid_tracker/common/data/datasource/cases_datasource.dart';
import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/getit_root.dart';
import 'package:injectable/injectable.dart';

abstract class CasesRepository {
  Future<List<CompleteCases>> getAllCasesByCountry();

  Future<List<CompleteCases>> getAllCasesByContinents(String continent);

  Future<CompleteCases> getCasesByCountry(String country);

  Future<List<CompleteCases>> getFavoriteCountries();

  Future<void> setFavoriteCountries(String favorite);

  Future<void> removeFavoriteCountry(String favorite);

  Future<bool> getFavoriteCountryCheck(String favorite);
}

@Injectable(as: CasesRepository)
class CountriesRepositoryImpl implements CasesRepository {
  final CasesDatasource _casesRemoteDatasource;
  final CasesDatasource _casesLocalDatasource;

  CountriesRepositoryImpl(@Named(DatasourceKeys.remote) this._casesRemoteDatasource,
      @Named(DatasourceKeys.local) this._casesLocalDatasource);

  @override
  Future<List<CompleteCases>> getAllCasesByCountry() async {
    return _casesRemoteDatasource.getAllCasesByCountry();
  }

  @override
  Future<CompleteCases> getCasesByCountry(String country) async {
    return _casesRemoteDatasource.getCasesByCountry(country);
  }

  @override
  Future<List<CompleteCases>> getAllCasesByContinents(String continent) async {
    return _casesRemoteDatasource.getAllCasesByContinents(continent);
  }

  @override
  Future<List<CompleteCases>> getFavoriteCountries() async {
    final result = await _casesLocalDatasource.getFavoriteCountries();
    return Future.wait(result.map((e) => getCasesByCountry(e)).toList());
  }

  @override
  Future<void> setFavoriteCountries(String favorite) async {
    _casesLocalDatasource.setFavoriteCountries(favorite);
  }

  @override
  Future<bool> getFavoriteCountryCheck(String favorite) async {
    return _casesLocalDatasource.getFavoriteCountryCheck(favorite);
  }

  @override
  Future<void> removeFavoriteCountry(String favorite) async {
    _casesLocalDatasource.removeFavoriteCountry(favorite);
  }
}
