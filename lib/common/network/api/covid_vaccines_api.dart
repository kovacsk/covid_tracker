import 'package:covid_tracker/model/json_models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CovidVaccinesApi {
  final _baseUrl = 'https://covid-api.mmediagroup.fr';

  Future<Map<String, Vaccinated>> getAllVaccinated() async {
    final response =
        await http.get(Uri.https('covid-api.mmediagroup.fr', 'v1/vaccines'));
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return responseData
        .map((key, value) => MapEntry(key, Vaccinated.fromJson(value)));
  }

  Future<Vaccinated> getVaccinatedByCountry(String country) async {
    final parameters = {'country': country};
    final response = await http.get(
        Uri.https('covid-api.mmediagroup.fr', 'v1/vaccines', parameters));
    return Vaccinated.fromJson(jsonDecode(response.body));
  }
}
