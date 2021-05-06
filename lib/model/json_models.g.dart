// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country(
    CountryData.fromJson(json['All'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'All': instance.countrydata,
    };

CountryData _$CountryDataFromJson(Map<String, dynamic> json) {
  return CountryData(
    json['confirmed'] as int?,
    json['recovered'] as int?,
    json['deaths'] as int?,
    json['country'] as String?,
    json['population'] as int?,
    json['continent'] as String?,
    json['abbreviation'] as String?,
    json['location'] as String?,
    json['iso'] as int?,
    json['capital_city'] as String?,
    json['updated'] as String?,
  );
}

Map<String, dynamic> _$CountryDataToJson(CountryData instance) =>
    <String, dynamic>{
      'confirmed': instance.confirmed,
      'recovered': instance.recovered,
      'deaths': instance.deaths,
      'country': instance.country,
      'population': instance.population,
      'continent': instance.continent,
      'abbreviation': instance.abbreviation,
      'location': instance.location,
      'iso': instance.iso,
      'capital_city': instance.capital_city,
      'updated': instance.updated,
    };

Vaccinated _$VaccinatedFromJson(Map<String, dynamic> json) {
  return Vaccinated(
    VaccinatedData.fromJson(json['All'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VaccinatedToJson(Vaccinated instance) =>
    <String, dynamic>{
      'All': instance.vaccinatedData,
    };

VaccinatedData _$VaccinatedDataFromJson(Map<String, dynamic> json) {
  return VaccinatedData(
    json['people_vaccinated'] as int?,
    json['people_partially_vaccinated'] as int?,
    json['population'] as int?,
  );
}

Map<String, dynamic> _$VaccinatedDataToJson(VaccinatedData instance) =>
    <String, dynamic>{
      'people_vaccinated': instance.people_vaccinated,
      'people_partially_vaccinated': instance.people_partially_vaccinated,
      'population': instance.population,
    };
