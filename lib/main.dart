import 'package:covid_tracker/common/navigation/app_navigation.dart';
import 'package:covid_tracker/details/country_detail_page.dart';
import 'package:covid_tracker/feature/bottom_navigation/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'common/getit_root.dart';
import 'lists/country_list_page.dart';
import 'model/favorite.dart';

late AppNavigation _appNavigation;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  _appNavigation = GetIt.I.get<AppNavigation>();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        bottomAppBarColor: Colors.lightBlueAccent,
      ),
      initialRoute: AppNavigation.initialRoute,
      routes: _appNavigation.routes,
    );
  }
}

