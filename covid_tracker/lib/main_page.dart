import 'package:covid_tracker/repositories/network_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'details/country_detail_page.dart';
import 'model/json_models.dart';

class MainPage extends StatefulWidget {
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  final repository = NWRepository();
  late Future<Country> country;
  late Future<Vaccinated> vaccinated;
  final String countryName = "Global";

  late Future<List<Country>> favoritCountries;

  @override
  void initState() {
    super.initState();

    favoritCountries = _getFavoriteCountries();
    country = repository.getCasesByCountry(countryName);
    vaccinated = repository.getVaccinatedByCountry(countryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: SizedBox(
                child: FutureBuilder<Country>(
                    future: country,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Hiba történt: ${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        var countryDetails = snapshot.data!.countrydata;
                        var confirmedpercent = 0.0;
                        var recovered = 0.0;
                        if (countryDetails.confirmed != null &&
                            countryDetails.population != null) {
                          confirmedpercent =
                              ((countryDetails.confirmed!.toDouble()) /
                                  (countryDetails.population!.toDouble()));
                        }
                        if (countryDetails.recovered != null &&
                            countryDetails.confirmed != null) {
                          recovered = ((countryDetails.recovered!.toDouble()) /
                              (countryDetails.confirmed!.toDouble()));
                        }

                        return Center(
                          child: Column(
                            children: [
                              Text(
                                "World Population: " +
                                    countryDetails.population.toString(),
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.0,
                              ),
                              Text(
                                "Confirmed Cases: " +
                                    countryDetails.confirmed.toString(),
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.0,
                              ),
                              Text(
                                "Deaths: " + countryDetails.deaths.toString(),
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.0,
                              ),
                              Text(
                                "Recovered: " +
                                    countryDetails.recovered.toString(),
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.0,
                              ),
                              Row(children: [
                                Expanded(
                                  child: CircularPercentIndicator(
                                    radius: 100.0,
                                    center: Text(
                                      (confirmedpercent * 100)
                                              .toInt()
                                              .toString() +
                                          "%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    footer: Text("Cases confirmed"),
                                    animation: true,
                                    animationDuration: 1200,
                                    lineWidth: 15.0,
                                    percent: confirmedpercent,
                                    circularStrokeCap: CircularStrokeCap.butt,
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.lightGreen,
                                  ),
                                ),
                                Expanded(
                                  child: CircularPercentIndicator(
                                    radius: 100.0,
                                    center: Text(
                                      (recovered * 100).toInt().toString() +
                                          "%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    footer: Text("Recovered"),
                                    animation: true,
                                    animationDuration: 1200,
                                    lineWidth: 15.0,
                                    percent: recovered,
                                    circularStrokeCap: CircularStrokeCap.butt,
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.lightGreen,
                                  ),
                                ),
                              ])
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              )),
              const Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              Expanded(
                  child: SizedBox(
                child: FutureBuilder<Vaccinated>(
                    future: vaccinated,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Hiba történt: ${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        var vaccinateDetails = snapshot.data!.vaccinatedData;
                        var fullvaccpercent = 0.0;
                        var partvaccpercent = 0.0;
                        if (vaccinateDetails.people_partially_vaccinated !=
                                null &&
                            vaccinateDetails.population != null) {
                          partvaccpercent = ((vaccinateDetails
                                  .people_partially_vaccinated!
                                  .toDouble()) /
                              (vaccinateDetails.population!.toDouble()));
                        }
                        if (vaccinateDetails.people_partially_vaccinated !=
                                null &&
                            vaccinateDetails.population != null) {
                          fullvaccpercent = ((vaccinateDetails
                                  .people_vaccinated!
                                  .toDouble()) /
                              (vaccinateDetails.population!.toDouble()));
                        }

                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Partially vaccinated: " +
                                    vaccinateDetails.people_partially_vaccinated
                                        .toString(),
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.0,
                              ),
                              Text(
                                "Total vaccinated: " +
                                    vaccinateDetails.people_vaccinated
                                        .toString(),
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.0,
                              ),
                              Row(children: [
                                Expanded(
                                  child: CircularPercentIndicator(
                                    radius: 100.0,
                                    center: Text(
                                      (partvaccpercent * 100)
                                              .toInt()
                                              .toString() +
                                          "%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    footer:
                                        Text("Population partially vaccinated"),
                                    animation: true,
                                    animationDuration: 1200,
                                    lineWidth: 15.0,
                                    percent: partvaccpercent,
                                    circularStrokeCap: CircularStrokeCap.butt,
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.lightGreen,
                                  ),
                                ),
                                Expanded(
                                  child: CircularPercentIndicator(
                                    radius: 100.0,
                                    center: Text(
                                      (fullvaccpercent * 100)
                                              .toInt()
                                              .toString() +
                                          "%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    footer: Text("Population fully vaccinated"),
                                    animation: true,
                                    animationDuration: 1200,
                                    lineWidth: 15.0,
                                    percent: fullvaccpercent,
                                    circularStrokeCap: CircularStrokeCap.butt,
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.lightGreen,
                                  ),
                                ),
                              ])
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              )),
              const Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              Expanded(
                child: SizedBox(
                  child: FutureBuilder<List<Country>>(
                      future: favoritCountries,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Hiba történt: ${snapshot.error}"),
                          );
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          var list = snapshot.data;
                          return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return new GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPageWidget(
                                              countryName: list![i]
                                                  .countrydata
                                                  .country
                                                  .toString(),
                                            ))),
                                child: FavoriteListItem(
                                  list![i],
                                ),
                              );
                            },
                            itemCount: list!.length,
                          );
                        } else {
                          return Center(
                            child: Text("Your favorites will appear here!"),
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Country>> _getFavoriteCountries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var retlist = <Country>[];
    if (prefs.containsKey("favorite")) {
      var list = prefs.getStringList("favorite");
      for (var element in list!) {
        var result = repository.getCasesByCountry(element);
        retlist.add(await result);
      }
    }
    return retlist;
  }
}

class FavoriteListItem extends StatelessWidget {
  final Country item;

  FavoriteListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Country: " + item.countrydata.country.toString(),
              textAlign: TextAlign.start,
            ),
            Text(
              "Capital: " + item.countrydata.capital_city.toString(),
              textAlign: TextAlign.start,
            ),
            Text(
              "Confirmed cases: " + item.countrydata.confirmed.toString(),
              textAlign: TextAlign.start,
            ),
            Text(
              "Confirmed deaths: " + item.countrydata.deaths.toString(),
              textAlign: TextAlign.start,
            ),
            Text(
              "Recovered: " + item.countrydata.recovered.toString(),
              textAlign: TextAlign.start,
            ),
            Expanded(
              child: CircularPercentIndicator(
                radius: 70.0,
                center: Text(
                  (_calcPercent() * 100).toInt().toString() + "%",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: Text("Confirmed cases"),
                animation: true,
                animationDuration: 1200,
                lineWidth: 10.0,
                percent: _calcPercent(),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.grey,
                progressColor: Colors.lightGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calcPercent() {
    if (item.countrydata.confirmed != null &&
        item.countrydata.population != null) {
      return (item.countrydata.confirmed!.toDouble() /
              item.countrydata.population!.toDouble())
          .toDouble();
    } else {
      return 0.0;
    }
  }
}
