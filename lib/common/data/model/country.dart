import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class CountryResponse {
  @JsonKey(name: "All")
  final CountryData countryData;

  CountryResponse({required this.countryData});

  Map<String, dynamic> toJson() => _$CountryResponseToJson(this);

  factory CountryResponse.fromJson(Map<String, dynamic> json) => _$CountryResponseFromJson(json);


}

@JsonSerializable()
class CountryData {
  final int? confirmed;
  final int? recovered;
  final int? deaths;
  final String? country;
  final int? population;
  final String? continent;
  final String? abbreviation;
  final String? location;
  final int? iso;
  final String? capital_city;
  final String? updated;

  CountryData(this.confirmed, this.recovered, this.deaths, this.country, this.population, this.continent,
      this.abbreviation, this.location, this.iso, this.capital_city, this.updated);

  Map<String, dynamic> toJson() => _$CountryDataToJson(this);

  factory CountryData.fromJson(Map<String, dynamic> json) => _$CountryDataFromJson(json);
}

class Country {
  final int confirmed;
  final int recovered;
  final int deaths;
  final String country;
  final int population;
  final String continent;
  final String abbreviation;
  final String location;
  final int iso;
  final String capital_city;
  final String updated;

  Country(
      {required this.confirmed,
      required this.recovered,
      required this.deaths,
      required this.country,
      required this.population,
      required this.continent,
      required this.abbreviation,
      required this.location,
      required this.iso,
      required this.capital_city,
      required this.updated});

  static Country get empty => Country(
      updated: "",
      recovered: 0,
      location: "",
      iso: 0,
      deaths: 0,
      continent: "",
      confirmed: 0,
      capital_city: "",
      abbreviation: "",
      population: 0,
      country: "");
}


extension CountryExtension on Country {
  double toDoubleConfirmedPercentage() {
    final val = (this.confirmed.toDouble() / this.population.toDouble());
    if (val > 1.0) {
      return 1.0;
    } else if (val < 0.0) {
      return 0.0;
    }
    return val;
  }
}
