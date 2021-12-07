import 'package:flutter/cupertino.dart';

import 'home_route.dart';

class HomeNavigation {
  static void pushHome(BuildContext context) {
    Navigator.pushNamed(context, HomeRoute.home);
  }
}
