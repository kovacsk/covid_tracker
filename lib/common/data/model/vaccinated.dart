import 'package:json_annotation/json_annotation.dart';

part 'vaccinated.g.dart';

@JsonSerializable()
class VaccinatedResponse {
  @JsonKey(name: "All")
  final VaccinatedData vaccinatedData;

  VaccinatedResponse(this.vaccinatedData);

  Map<String, dynamic> toJson() => _$VaccinatedResponseToJson(this);

  factory VaccinatedResponse.fromJson(Map<String, dynamic> json) => _$VaccinatedResponseFromJson(json);
}

@JsonSerializable()
class VaccinatedData {
  final int? people_vaccinated;
  final int? people_partially_vaccinated;
  final int? population;
  final String? country;
  final String? abbreviation;
  final String? updated;

  VaccinatedData(this.people_vaccinated, this.people_partially_vaccinated, this.population, this.country,
      this.abbreviation, this.updated);

  Map<String, dynamic> toJson() => _$VaccinatedDataToJson(this);

  factory VaccinatedData.fromJson(Map<String, dynamic> json) => _$VaccinatedDataFromJson(json);
}

class Vaccines {
  final int vaccinated;
  final int partiallyVaccinated;
  final int population;
  final String country;
  final String abbreviation;
  final String updated;

  Vaccines(
      {required this.vaccinated,
      required this.partiallyVaccinated,
      required this.population,
      required this.country,
      required this.updated,
      required this.abbreviation});
}

extension VaccinesExtension on Vaccines {
  double toDoubleVaccinatedPercentage() {
    final val = (this.vaccinated.toDouble() / this.population.toDouble());
    if (val > 1.0) {
      return 1.0;
    } else if (val < 0.0) {
      return 0.0;
    }
    return val;
  }
}
