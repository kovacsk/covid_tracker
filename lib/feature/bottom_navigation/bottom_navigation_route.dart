import 'package:flutter/cupertino.dart';

import 'bottom_navigation_screen.dart';

class BottomNavigationRoute{
  static const bottom = "/bottom";

  Map<String, WidgetBuilder> getRoute() =>{
    bottom: (context) => BottomNavigation()
  };
}