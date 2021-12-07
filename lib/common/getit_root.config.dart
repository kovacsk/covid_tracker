// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../feature/continents/presentation/continents_bloc.dart' as _i18;
import '../feature/countries/presentation/countries_bloc.dart' as _i19;
import '../feature/countries/presentation/detail/data/usecase/get_favorite_country_check_usecase.dart'
    as _i14;
import '../feature/countries/presentation/detail/data/usecase/remove_favorite_country_usecase.dart'
    as _i16;
import '../feature/countries/presentation/detail/presentation/country_detail_bloc.dart'
    as _i20;
import '../feature/home/data/usecase/get_favorite_countries_usecase.dart'
    as _i13;
import '../feature/home/presentation/home_bloc.dart' as _i15;
import 'data/datasource/cases_datasource.dart' as _i4;
import 'data/datasource/cases_local_datasource.dart' as _i5;
import 'data/datasource/cases_remote_datasource.dart' as _i8;
import 'data/repository/cases_repository.dart' as _i9;
import 'data/usecase/get_all_cases_by_continents_usecase.dart' as _i11;
import 'data/usecase/get_all_cases_by_country_usecase.dart' as _i12;
import 'data/usecase/get_all_cases_usecase.dart' as _i10;
import 'data/usecase/set_favorite_country_usecase.dart' as _i17;
import 'di/network_module.dart' as _i21;
import 'navigation/app_navigation.dart' as _i3;
import 'network/api/covid_cases_api.dart' as _i6;
import 'network/api/covid_vaccines_api.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  gh.factory<_i3.AppNavigation>(() => _i3.AppNavigation());
  gh.factory<_i4.CasesDatasource>(() => _i5.CasesLocalDatasource(),
      instanceName: 'local');
  gh.factory<_i6.CovidCasesApi>(() => networkModule.covidCasesApi);
  gh.factory<_i7.CovidVaccinesApi>(() => networkModule.covidVaccinesApi);
  gh.factory<_i4.CasesDatasource>(
      () => _i8.CasesRemoteDatasource(
          get<_i6.CovidCasesApi>(), get<_i7.CovidVaccinesApi>()),
      instanceName: 'remote');
  gh.factory<_i9.CasesRepository>(() => _i9.CountriesRepositoryImpl(
      get<_i4.CasesDatasource>(instanceName: 'remote'),
      get<_i4.CasesDatasource>(instanceName: 'local')));
  gh.factory<_i10.GetAllCasesUseCase>(
      () => _i10.GetAllCasesUseCaseImpl(get<_i9.CasesRepository>()));
  gh.factory<_i11.GetCasesByContinentsUseCase>(
      () => _i11.GetCasesByContinentsUseCaseImpl(get<_i9.CasesRepository>()));
  gh.factory<_i12.GetCasesByCountryUseCase>(
      () => _i12.GetCasesByCountryUseCaseImpl(get<_i9.CasesRepository>()));
  gh.factory<_i13.GetFavoriteCountriesUseCase>(
      () => _i13.GetFavoriteCountriesUseCaseImpl(get<_i9.CasesRepository>()));
  gh.factory<_i14.GetFavoriteCountryCheckUseCase>(() =>
      _i14.GetFavoriteCountryCheckUseCaseImpl(get<_i9.CasesRepository>()));
  gh.factory<_i15.HomeBloc>(() => _i15.HomeBloc(
      get<_i12.GetCasesByCountryUseCase>(),
      get<_i13.GetFavoriteCountriesUseCase>()));
  gh.factory<_i16.RemoveFavoriteCountryUseCase>(
      () => _i16.SetFavoriteCountryUseCaseImpl(get<_i9.CasesRepository>()));
  gh.factory<_i17.SetFavoriteCountryUseCase>(
      () => _i17.SetFavoriteCountryUseCaseImpl(get<_i9.CasesRepository>()));
  gh.factory<_i18.ContinentsBloc>(
      () => _i18.ContinentsBloc(get<_i11.GetCasesByContinentsUseCase>()));
  gh.factory<_i19.CountriesBloc>(
      () => _i19.CountriesBloc(get<_i10.GetAllCasesUseCase>()));
  gh.factory<_i20.CountryDetailBloc>(() => _i20.CountryDetailBloc(
      get<_i14.GetFavoriteCountryCheckUseCase>(),
      get<_i17.SetFavoriteCountryUseCase>(),
      get<_i16.RemoveFavoriteCountryUseCase>()));
  return get;
}

class _$NetworkModule extends _i21.NetworkModule {
  @override
  _i6.CovidCasesApi get covidCasesApi => _i6.CovidCasesApi();
  @override
  _i7.CovidVaccinesApi get covidVaccinesApi => _i7.CovidVaccinesApi();
}
