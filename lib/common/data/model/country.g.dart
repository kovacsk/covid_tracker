// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryResponse _$CountryResponseFromJson(Map<String, dynamic> json) {
  return CountryResponse(
    countryData: CountryData.fromJson(json['All'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CountryResponseToJson(CountryResponse instance) =>
    <String, dynamic>{
      'All': instance.countryData,
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
