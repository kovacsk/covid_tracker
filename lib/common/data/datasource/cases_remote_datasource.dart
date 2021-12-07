import 'package:covid_tracker/common/data/model/country.dart';
import 'package:covid_tracker/common/data/model/vaccinated.dart';
import 'package:covid_tracker/common/getit_root.dart';
import 'package:covid_tracker/common/network/api/covid_cases_api.dart';
import 'package:covid_tracker/common/network/api/covid_vaccines_api.dart';
import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:injectable/injectable.dart';

import 'cases_datasource.dart';

@Named(DatasourceKeys.remote)
@Injectable(as: CasesDatasource)
class CasesRemoteDatasource implements CasesDatasource {
  final CovidCasesApi _covidCasesApi;
  final CovidVaccinesApi _covidVaccinesApi;

  CasesRemoteDatasource(this._covidCasesApi, this._covidVaccinesApi);

  @override
  Future<List<CompleteCases>> getAllCasesByCountry() async {
    final countryResponse = await _covidCasesApi.getAllCases();
    final vaccinesResponse = await _covidVaccinesApi.getAllVaccinated();
    final List<Country> countryList = countryResponse.entries
        .map((e) => Country(
            country: e.value.countryData.country ?? "",
            population: e.value.countryData.population ?? 0,
            abbreviation: e.value.countryData.abbreviation ?? "",
            capital_city: e.value.countryData.capital_city ?? "",
            confirmed: e.value.countryData.confirmed ?? 0,
            continent: e.value.countryData.continent ?? "",
            deaths: e.value.countryData.deaths ?? 0,
            iso: e.value.countryData.iso ?? 0,
            location: e.value.countryData.location ?? "",
            recovered: e.value.countryData.recovered ?? 0,
            updated: e.value.countryData.updated ?? ""))
        .toList();

    List<Vaccines> vaccinesList = vaccinesResponse.entries
        .map((e) => Vaccines(
            abbreviation: e.value.vaccinatedData.abbreviation ?? "",
            updated: e.value.vaccinatedData.updated ?? "",
            country: e.value.vaccinatedData.country ?? "",
            partiallyVaccinated: e.value.vaccinatedData.people_partially_vaccinated ?? 0,
            population: e.value.vaccinatedData.population ?? 0,
            vaccinated: e.value.vaccinatedData.people_vaccinated ?? 0))
        .toList();

    List<CompleteCases> casesList = [];

    for (var country in countryList) {
      for (var vaccine in vaccinesList) {
        if (country.country == vaccine.country && country.country.isNotEmpty) {
          casesList.add(CompleteCases(
            country: country.country,
            population: country.population,
            abbreviation: country.abbreviation,
            capital_city: country.capital_city,
            confirmed: country.confirmed,
            continent: country.continent,
            deaths: country.deaths,
            iso: country.iso,
            location: country.location,
            recovered: country.recovered,
            updated: country.updated,
            vaccinated: vaccine.vaccinated,
            partiallyVaccinated: vaccine.partiallyVaccinated,
          ));
        }
      }
    }

    return casesList;
  }

  @override
  Future<CompleteCases> getCasesByCountry(String country) async {
    final countryResponse = await _covidCasesApi.getCasesByCountry(country);
    final vaccineResponse = await _covidVaccinesApi.getVaccinatedByCountry(country);
    return CompleteCases(
        confirmed: countryResponse.countryData.confirmed ?? 0,
        recovered: countryResponse.countryData.recovered ?? 0,
        deaths: countryResponse.countryData.deaths ?? 0,
        country: countryResponse.countryData.country ?? "",
        population: countryResponse.countryData.population ?? 0,
        continent: countryResponse.countryData.continent ?? "",
        abbreviation: countryResponse.countryData.abbreviation ?? "",
        location: countryResponse.countryData.location ?? "",
        iso: countryResponse.countryData.iso ?? 0,
        capital_city: countryResponse.countryData.capital_city ?? "",
        updated: countryResponse.countryData.updated ?? "",
        partiallyVaccinated: vaccineResponse.vaccinatedData.people_partially_vaccinated ?? 0,
        vaccinated: vaccineResponse.vaccinatedData.people_vaccinated ?? 0);
  }

  @override
  Future<List<CompleteCases>> getAllCasesByContinents(String continent) async {
    final countryResponse = await _covidCasesApi.getCasesByContinents(continent);
    final vaccineResponse = await _covidVaccinesApi.getCasesByContinents(continent);
    final List<Country> countryList = countryResponse.entries
        .map((e) => Country(
            country: e.value.countryData.country ?? "",
            population: e.value.countryData.population ?? 0,
            abbreviation: e.value.countryData.abbreviation ?? "",
            capital_city: e.value.countryData.capital_city ?? "",
            confirmed: e.value.countryData.confirmed ?? 0,
            continent: e.value.countryData.continent ?? "",
            deaths: e.value.countryData.deaths ?? 0,
            iso: e.value.countryData.iso ?? 0,
            location: e.value.countryData.location ?? "",
            recovered: e.value.countryData.recovered ?? 0,
            updated: e.value.countryData.updated ?? ""))
        .toList();

    List<Vaccines> vaccinesList = vaccineResponse.entries
        .map((e) => Vaccines(
            abbreviation: e.value.vaccinatedData.abbreviation ?? "",
            updated: e.value.vaccinatedData.updated ?? "",
            country: e.value.vaccinatedData.country ?? "",
            partiallyVaccinated: e.value.vaccinatedData.people_partially_vaccinated ?? 0,
            population: e.value.vaccinatedData.population ?? 0,
            vaccinated: e.value.vaccinatedData.people_vaccinated ?? 0))
        .toList();

    List<CompleteCases> casesList = [];

    for (var country in countryList) {
      for (var vaccine in vaccinesList) {
        if (country.country == vaccine.country && country.country.isNotEmpty) {
          casesList.add(CompleteCases(
            country: country.country,
            population: country.population,
            abbreviation: country.abbreviation,
            capital_city: country.capital_city,
            confirmed: country.confirmed,
            continent: country.continent,
            deaths: country.deaths,
            iso: country.iso,
            location: country.location,
            recovered: country.recovered,
            updated: country.updated,
            vaccinated: vaccine.vaccinated,
            partiallyVaccinated: vaccine.partiallyVaccinated,
          ));
        }
      }
    }

    return casesList;
  }

  @override
  Future<List<String>> getFavoriteCountries() {
    // TODO: implement getFavoriteCountries
    throw UnimplementedError();
  }

  @override
  Future<void> setFavoriteCountries(String favorite) {
    // TODO: implement setFavoriteCountries
    throw UnimplementedError();
  }

  @override
  Future<bool> getFavoriteCountryCheck(String favorite) {
    // TODO: implement getFavoriteCountryCheck
    throw UnimplementedError();
  }

  @override
  Future<void> removeFavoriteCountry(String favorite) {
    // TODO: implement removeFavoriteCountry
    throw UnimplementedError();
  }
}
