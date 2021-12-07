abstract class CountriesEvent {}

class CountriesOnCreated extends CountriesEvent {}

class CountriesOnClick extends CountriesEvent {}

class CountriesOnSearched extends CountriesEvent {
  final String value;

  CountriesOnSearched(this.value);
}
