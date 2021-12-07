import 'package:covid_tracker/feature/home/presentation/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeRoute{
  static const home = "/home";

  Map<String, WidgetBuilder> getRoute() =>{
    home: (context) => HomeScreen()
  };
}