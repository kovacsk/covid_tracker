import 'package:covid_tracker/common/data/model/country.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CovidCasesApi {
  final _baseUrl = 'https://covid-api.mmediagroup.fr';

  Future<CountryResponse> getCasesByCountry(String country) async {
    final parameters = {'country': country};
    final response = await http
        .get(Uri.https('covid-api.mmediagroup.fr', 'v1/cases', parameters));
    return CountryResponse.fromJson(jsonDecode(response.body));
  }

  Future<Map<String, CountryResponse>> getAllCases() async {
    final response =
        await http.get(Uri.https('covid-api.mmediagroup.fr', 'v1/cases'));
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return responseData
        .map((key, value) => MapEntry(key, CountryResponse.fromJson(value)));
  }

  Future<Map<String, CountryResponse>> getCasesByContinents(String continent) async {
    final parameters = {'continent': continent};
    final response = await http
        .get(Uri.https('covid-api.mmediagroup.fr', 'v1/cases', parameters));
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return responseData
        .map((key, value) => MapEntry(key, CountryResponse.fromJson(value)));
  }
}
