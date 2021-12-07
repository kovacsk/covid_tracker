import 'package:covid_tracker/feature/continents/data/model/continents.dart';

abstract class ContinentsEvent {}

class ContinentsOnCreated extends ContinentsEvent {
}

class ContinentsDropdownChanged extends ContinentsEvent {
  final Continents newContinent;

  ContinentsDropdownChanged(this.newContinent);
}

class ContinentsOnClick extends ContinentsEvent {}
