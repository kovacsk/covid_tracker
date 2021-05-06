import 'package:json_annotation/json_annotation.dart';

part 'json_models.g.dart';




@JsonSerializable()
class Country{
  @JsonKey(name: "All") final CountryData countrydata;

  Country(this.countrydata);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
  factory Country.fromJson(Map<String,dynamic> json) => _$CountryFromJson(json);

}

@JsonSerializable()
class CountryData{
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

  CountryData(this.confirmed, this.recovered, this.deaths, this.country, this.population, this.continent, this.abbreviation, this.location, this.iso, this.capital_city, this.updated);


  Map<String, dynamic> toJson() => _$CountryDataToJson(this);
  factory CountryData.fromJson(Map<String,dynamic> json) => _$CountryDataFromJson(json);



}
@JsonSerializable()
class Vaccinated{
  @JsonKey(name: "All") final VaccinatedData vaccinatedData;

  Vaccinated(this.vaccinatedData);

  Map<String, dynamic> toJson() => _$VaccinatedToJson(this);
  factory Vaccinated.fromJson(Map<String,dynamic> json) => _$VaccinatedFromJson(json);
}



@JsonSerializable()
class VaccinatedData{
  final int? people_vaccinated;
  final int? people_partially_vaccinated;
  final int? population;
  VaccinatedData(this.people_vaccinated,this.people_partially_vaccinated, this.population);

  Map<String, dynamic> toJson() => _$VaccinatedDataToJson(this);
  factory VaccinatedData.fromJson(Map<String,dynamic> json) => _$VaccinatedDataFromJson(json);

}