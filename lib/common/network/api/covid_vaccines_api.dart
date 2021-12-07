import 'dart:convert';
import 'package:covid_tracker/common/data/model/vaccinated.dart';
import 'package:http/http.dart' as http;

class CovidVaccinesApi {
  final _baseUrl = 'https://covid-api.mmediagroup.fr';

  Future<Map<String, VaccinatedResponse>> getAllVaccinated() async {
    final response =
        await http.get(Uri.https('covid-api.mmediagroup.fr', 'v1/vaccines'));
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return responseData
        .map((key, value) => MapEntry(key, VaccinatedResponse.fromJson(value)));
  }

  Future<VaccinatedResponse> getVaccinatedByCountry(String country) async {
    final parameters = {'country': country};
    final response = await http.get(
        Uri.https('covid-api.mmediagroup.fr', 'v1/vaccines', parameters));
    return VaccinatedResponse.fromJson(jsonDecode(response.body));
  }

  Future<Map<String, VaccinatedResponse>> getCasesByContinents(String continent) async {
    final parameters = {'continent': continent};
    final response = await http
        .get(Uri.https('covid-api.mmediagroup.fr', 'v1/vaccines', parameters));
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return responseData
        .map((key, value) => MapEntry(key, VaccinatedResponse.fromJson(value)));
  }
}
