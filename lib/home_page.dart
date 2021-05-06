



import 'package:covid_tracker/lists/continetns_list_page.dart';
import 'package:covid_tracker/main_page.dart';
import 'package:covid_tracker/lists/vaccine_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lists/country_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _routes = <Widget>[
    MainPage(),
    ContinentsPage(),
    CountryPage(),
    VaccinePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Covid Tracker'),
      ),
      body: Center(
        child: _routes.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Continents',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_rounded),
            label: 'Countries',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location),
            label: 'Vaccines',

          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.lightGreen,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
