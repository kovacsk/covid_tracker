enum Continents {
  europe,
  asia,
  africa,
  south_america,
  north_america,
  oceania,
}

extension ContinentsNameExtension on Continents {
  String get name {
    switch (this) {
      case Continents.europe:
        return "Europe";
      case Continents.asia:
        return "Asia";
      case Continents.africa:
        return "Africa";
      case Continents.south_america:
        return "South America";
      case Continents.north_america:
        return "North America";
      case Continents.oceania:
        return "Oceania";
    }
  }
}

