import 'package:covid_tracker/feature/continents/presentation/continents_screen.dart';
import 'package:flutter/cupertino.dart';

class ContinentsRoute {
  static const continents = "/continents";

  Map<String, WidgetBuilder> getRoute() => {continents: (context) => ContinentsScreen()};
}
