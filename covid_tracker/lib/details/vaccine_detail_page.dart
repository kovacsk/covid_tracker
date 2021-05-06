import 'package:covid_tracker/model/json_models.dart';

import 'package:covid_tracker/repositories/network_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VaccineDetailPageWidget extends StatefulWidget {
  final String countryName;

  VaccineDetailPageWidget({required String countryName})
      : this.countryName = countryName;

  _VaccineDetailPageWidget createState() => _VaccineDetailPageWidget(countryName);
}

class _VaccineDetailPageWidget extends State<VaccineDetailPageWidget> {
  final String countryName;

  _VaccineDetailPageWidget(this.countryName);

  final repository = NWRepository();
  late Future<Vaccinated> vaccinated;

  @override
  void initState() {
    super.initState();
    vaccinated = repository.getVaccinatedByCountry(countryName);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(countryName),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var request = repository.getVaccinatedByCountry(countryName);
          setState(() {
            vaccinated = request;
          });
          await request;
        },
        child: Container(
          child: FutureBuilder<Vaccinated>(
              future: vaccinated,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Hiba történt: ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  var vaccineDetails = snapshot.data!.vaccinatedData;
                  var parciallivacced = 0.0;
                  var fullyvacced = 0.0;
                  if (vaccineDetails.people_vaccinated != null &&
                      vaccineDetails.population != null) {
                    fullyvacced = ((vaccineDetails.people_vaccinated!.toDouble()) /
                        (vaccineDetails.population!.toDouble()));
                  }
                  if (vaccineDetails.people_partially_vaccinated != null &&
                      vaccineDetails.population != null) {
                    parciallivacced = ((vaccineDetails.people_partially_vaccinated!.toDouble()) /
                        (vaccineDetails.population!.toDouble()));
                  }


                  return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Text(countryName,
                                  style: TextStyle(fontWeight: FontWeight.bold),),
                                Text("Population: " +
                                    vaccineDetails.population.toString()),
                                Text("Part.vaccinated: " +
                                    vaccineDetails.people_partially_vaccinated.toString()),
                                Text("Vaccinated: " +
                                    vaccineDetails.people_vaccinated.toString()),
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
                                          ((parciallivacced) * 100)
                                              .toInt()
                                              .toString() +
                                              "%",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                        footer: Text(
                                          "Part. vaccinated",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        animation: true,
                                        animationDuration: 1200,
                                        lineWidth: 15.0,
                                        percent: (parciallivacced),
                                        circularStrokeCap:
                                        CircularStrokeCap.butt,
                                        backgroundColor: Colors.grey,
                                        progressColor: Colors.lightGreen,
                                      ),
                                    ),
                                    Expanded(
                                      child: CircularPercentIndicator(
                                        radius: 120.0,
                                        center: Text(
                                          ((fullyvacced) * 100)
                                              .toInt()
                                              .toString() +
                                              "%",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                        footer: Text(
                                          "Vaccinated",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        animation: true,
                                        animationDuration: 1200,
                                        lineWidth: 15.0,
                                        percent: (fullyvacced),
                                        circularStrokeCap:
                                        CircularStrokeCap.butt,
                                        backgroundColor: Colors.grey,
                                        progressColor: Colors.lightGreen,
                                      ),
                                    ),
                                  ],

                                ),
                              ],
                            ),
                          ),
                        )
                      ] );
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
