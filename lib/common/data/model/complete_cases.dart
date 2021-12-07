class CompleteCases {
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
  final int vaccinated;
  final int partiallyVaccinated;

  CompleteCases({
    required this.confirmed,
    required this.recovered,
    required this.deaths,
    required this.country,
    required this.population,
    required this.continent,
    required this.abbreviation,
    required this.location,
    required this.iso,
    required this.capital_city,
    required this.updated,
    required this.vaccinated,
    required this.partiallyVaccinated,
  });

  static CompleteCases get empty => CompleteCases(
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
      country: "",
      partiallyVaccinated: 0,
      vaccinated: 0);
}

extension VaccinesExtension on CompleteCases {
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

extension CountryExtension on CompleteCases {
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
