import 'package:covid_tracker/common/network/api/covid_cases_api.dart';
import 'package:covid_tracker/common/network/api/covid_vaccines_api.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule{

  @injectable
  CovidCasesApi get covidCasesApi;

  @injectable
  CovidVaccinesApi get covidVaccinesApi;
}