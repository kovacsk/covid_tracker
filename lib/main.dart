import 'package:covid_tracker/details/country_detail_page.dart';
import 'package:covid_tracker/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'lists/country_list_page.dart';
import 'model/favorite.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:  (context) => FavoritedCountries(),
      child: MaterialApp(
        title: 'Covid Tracker',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          bottomAppBarColor: Colors.lightGreen,
        ),
        home: HomePage(),
      ),
    );
  }
}

