import 'package:covid_tracker/model/favorite.dart';
import 'package:covid_tracker/model/json_models.dart';

import 'package:covid_tracker/repositories/network_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPageWidget extends StatefulWidget {
  final String countryName;

  DetailPageWidget({required String countryName})
      : this.countryName = countryName;

  _DetailPageWidgetState createState() => _DetailPageWidgetState(countryName);
}

class _DetailPageWidgetState extends State<DetailPageWidget> {
  final String countryName;

  _DetailPageWidgetState(this.countryName);

  final repository = NWRepository();
  late Future<Country> country;

  @override
  void initState() {
    super.initState();
    country = repository.getCasesByCountry(countryName);
  }

  Future<bool> _getFavoriteVal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("favorite")) {
      var list = prefs.getStringList("favorite");
      if (list!.contains(countryName)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void _setFavoriteVal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("favorite")) {
      var list = prefs.getStringList("favorite");
      if (list!.contains(countryName)) {
        // ha már bennevan tehát töröljük
        list.remove(countryName);
        prefs.clear();
        prefs.setStringList("favorite", list);
      } else {
        list.add(countryName);
        prefs.clear();
        prefs.setStringList("favorite", list);
      }
    } else {
      var list = [countryName];
      prefs.setStringList("favorite", list);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(countryName),
        actions: [
          GestureDetector(
            child: Checkbox(
              value: context.watch<FavoritedCountries>().list.contains(countryName),
              onChanged: (_) => context.read<FavoritedCountries>().changeCountry(countryName),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var request = repository.getCasesByCountry(countryName);
          setState(() {
            country = request;
          });
          await request;
        },
        child: Container(
          child: FutureBuilder<Country>(
              future: country,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Hiba történt: ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  var countryDetails = snapshot.data!.countrydata;
                  var deaths = 0.0;
                  var confirmed = 0.0;
                  var recovered = 0.0;
                  if (countryDetails.confirmed != null &&
                      countryDetails.population != null) {
                    confirmed = ((countryDetails.confirmed!.toDouble()) /
                        (countryDetails.population!.toDouble()));
                  }
                  if (countryDetails.deaths != null &&
                      countryDetails.confirmed != null) {
                    deaths = ((countryDetails.deaths!.toDouble()) /
                        (countryDetails.confirmed!.toDouble()));
                  }
                  if (countryDetails.recovered != null &&
                      countryDetails.confirmed != null) {
                    recovered = ((countryDetails.recovered!.toDouble()) /
                        (countryDetails.confirmed!.toDouble()));
                  }

                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              countryDetails.country.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Capital: " +
                                countryDetails.capital_city.toString()),
                            Text("Continent: " +
                                countryDetails.continent.toString()),
                            Text("Population: " +
                                countryDetails.population.toString()),
                            Text("Cases: " +
                                countryDetails.confirmed.toString()),
                            Text("Recovered: " +
                                countryDetails.recovered.toString()),
                            Text("Deaths: " + countryDetails.deaths.toString()),
                            Text("Updated: " +
                                countryDetails.updated.toString()),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CircularPercentIndicator(
                                    radius: 120.0,
                                    center: Text(
                                      ((recovered) * 100).toInt().toString() +
                                          "%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    footer: Text(
                                      "Recovered",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    animation: true,
                                    animationDuration: 1200,
                                    lineWidth: 15.0,
                                    percent: (recovered),
                                    circularStrokeCap: CircularStrokeCap.butt,
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.lightGreen,
                                  ),
                                ),
                                Expanded(
                                  child: CircularPercentIndicator(
                                    radius: 120.0,
                                    center: Text(
                                      ((deaths) * 100).toInt().toString() + "%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    footer: Text(
                                      "Death",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    animation: true,
                                    animationDuration: 1200,
                                    lineWidth: 15.0,
                                    percent: (deaths),
                                    circularStrokeCap: CircularStrokeCap.butt,
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.lightGreen,
                                  ),
                                ),
                              ],
                            ),
                            Center(
                                child: CircularPercentIndicator(
                                  radius: 160.0,
                                  center: Text(
                                    ((confirmed) * 100).toInt().toString() +
                                        "%",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  footer: Text(
                                    "Cases",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  animation: true,
                                  animationDuration: 1200,
                                  lineWidth: 15.0,
                                  percent: (confirmed),
                                  circularStrokeCap: CircularStrokeCap.butt,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.lightGreen,
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                  ]);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final CountryData item;

  const ListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              item.country.toString(),
              textAlign: TextAlign.start,
            ),
            Text(
              item.abbreviation.toString(),
              textAlign: TextAlign.start,
            ),
            Text(
              item.capital_city.toString(),
              textAlign: TextAlign.start,
            ),
            Text(
              item.confirmed.toString(),
              textAlign: TextAlign.start,
            ),
            Text(
              item.deaths.toString(),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
