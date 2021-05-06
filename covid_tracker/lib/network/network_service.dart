import 'dart:convert';


import 'package:http/http.dart' as http;

import 'package:covid_tracker/model/json_models.dart';



class NetworkService {

  final String _baseUrl = 'https://covid-api.mmediagroup.fr';


  Future<Country> getCasesByCountry(String country) async{
    var queriParameters = {'country': country};
    var response = await http.get(Uri.https('covid-api.mmediagroup.fr','v1/cases',queriParameters));
    return Country.fromJson(jsonDecode(response.body));
  }
  Future<Map<String, Country>> getAllCases() async{
    var response = await http.get(Uri.https('covid-api.mmediagroup.fr','v1/cases'));
    var responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return responseData.map((key, value) => MapEntry(key, Country.fromJson(value)));
  }
  Future<Map<String, Country>> getCasesByContinents(String continent) async{
    var queriParameters = {'continent': continent};
    var response = await http.get(Uri.https('covid-api.mmediagroup.fr','v1/cases',queriParameters));
    var responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return responseData.map((key, value) => MapEntry(key, Country.fromJson(value)));
  }
  Future<Map<String, Vaccinated>> getAllVaccinated() async{
    var response = await http.get(Uri.https('covid-api.mmediagroup.fr','v1/vaccines'));
    var responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return responseData.map((key, value) => MapEntry(key, Vaccinated.fromJson(value)));
  }

  Future<Vaccinated> getVaccinatedByCountry(String country) async{
    var queriParameters = {'country': country};
    var response = await http.get(Uri.https('covid-api.mmediagroup.fr','v1/vaccines',queriParameters));
    return Vaccinated.fromJson(jsonDecode(response.body));
  }


}