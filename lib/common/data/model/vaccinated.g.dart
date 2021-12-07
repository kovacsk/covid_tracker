// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccinated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VaccinatedResponse _$VaccinatedResponseFromJson(Map<String, dynamic> json) {
  return VaccinatedResponse(
    VaccinatedData.fromJson(json['All'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VaccinatedResponseToJson(VaccinatedResponse instance) =>
    <String, dynamic>{
      'All': instance.vaccinatedData,
    };

VaccinatedData _$VaccinatedDataFromJson(Map<String, dynamic> json) {
  return VaccinatedData(
    json['people_vaccinated'] as int?,
    json['people_partially_vaccinated'] as int?,
    json['population'] as int?,
    json['country'] as String?,
    json['abbreviation'] as String?,
    json['updated'] as String?,
  );
}

Map<String, dynamic> _$VaccinatedDataToJson(VaccinatedData instance) =>
    <String, dynamic>{
      'people_vaccinated': instance.people_vaccinated,
      'people_partially_vaccinated': instance.people_partially_vaccinated,
      'population': instance.population,
      'country': instance.country,
      'abbreviation': instance.abbreviation,
      'updated': instance.updated,
    };
