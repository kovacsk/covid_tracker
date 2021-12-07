import 'package:covid_tracker/feature/countries/presentation/countries_screen.dart';
import 'package:covid_tracker/feature/countries/presentation/detail/presentation/country_detail_screen.dart';
import 'package:flutter/cupertino.dart';

class CountriesRoute {
  static const countries = "/countries";
  static const countryDetail = "/countries/detail";

  Map<String, WidgetBuilder> getRoute() => {
        countries: (context) => CountriesScreen(),
        countryDetail: (context) => CountryDetailScreen()
      };
}
