import 'package:covid_tracker/feature/bottom_navigation/bottom_navigation_route.dart';
import 'package:covid_tracker/feature/continents/navigation/continents_route.dart';
import 'package:covid_tracker/feature/countries/navigation/countries_navigation.dart';
import 'package:covid_tracker/feature/countries/navigation/countries_route.dart';
import 'package:covid_tracker/feature/home/navigation/home_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppNavigation {
  static const String initialRoute = BottomNavigationRoute.bottom;

  Map<String, WidgetBuilder> get routes => {}
    ..addAll(ContinentsRoute().getRoute())
    ..addAll(BottomNavigationRoute().getRoute())
    ..addAll(CountriesRoute().getRoute())
    ..addAll(HomeRoute().getRoute());
}
