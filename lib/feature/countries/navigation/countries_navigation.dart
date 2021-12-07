import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:flutter/cupertino.dart';
import 'countries_route.dart';

class CountriesNavigation {
  static void pushCountries(BuildContext context) {
    Navigator.pushNamed(context, CountriesRoute.countries);
  }

  static void pushCountryDetail(
      BuildContext context, CompleteCases countryNavigationArgument) {
    Navigator.pushNamed(context, CountriesRoute.countryDetail,
        arguments: countryNavigationArgument);
  }
}
