import 'package:covid_tracker/feature/continents/navigation/continents_route.dart';
import 'package:flutter/cupertino.dart';


class ContinentsNavigation {
  static void pushContinents(BuildContext context) {
    Navigator.pushNamed(context, ContinentsRoute.continents);
  }
}
