import 'dart:collection';

import 'package:covid_tracker/model/json_models.dart';

import 'package:covid_tracker/repositories/network_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../details/country_detail_page.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final repository = NWRepository();
  late Future<Map<String, Country>> allCases;

  @override
  void initState() {
    super.initState();
    allCases = repository.getAllCases();
  }

  String dropdownValue = 'Cases';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          var request = repository.getAllCases();
          setState(() {
            allCases = request;
          });
          await request;
        },
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(children: [
                      Text("Sort by: "),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black87),
                        underline: Container(
                          height: 2,
                          color: Colors.black87,
                        ),
                        onChanged: (String? newValue) async {
                          var request = repository.getAllCases();
                          setState(() {
                            dropdownValue = newValue!;
                            allCases = request;
                          });
                        },
                        items: <String>['Cases', 'Deaths', 'Recovered']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ]),
                  ),
                ]),
            Expanded(
              child: SizedBox(
                child: FutureBuilder<Map<String, Country>>(
                    future: allCases,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Hiba történt: ${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        var countryDetails = snapshot.data;
                        var list = countryDetails!.entries.toList();
                        if (dropdownValue == "Cases") {
                          list.sort((b, a) => a.value.countrydata.confirmed!
                              .compareTo(b.value.countrydata.confirmed!));
                        } else if (dropdownValue == "Deaths") {
                          list.sort((b, a) => a.value.countrydata.deaths!
                              .compareTo(b.value.countrydata.deaths!));
                        } else if (dropdownValue == "Recovered") {
                          list.sort((b, a) => a.value.countrydata.recovered!
                              .compareTo(b.value.countrydata.recovered!));
                        }
                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return new GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPageWidget(
                                            countryName: list[i].key,
                                          ))),
                              child: ListItem(
                                list[i].value,
                                name: list[i].key,
                              ),
                            );
                          },
                          itemCount: list.length,
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String name;
  final Country item;

  const ListItem(
    this.item, {
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
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
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularPercentIndicator(
                  radius: 50.0,
                  center: Text(
                    (_calcPercent() * 100).toInt().toString() + "%",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  footer: Text(
                    "Cases",
                    style: TextStyle(fontSize: 10),
                  ),
                  animation: true,
                  animationDuration: 1200,
                  lineWidth: 10.0,
                  percent: _calcPercent(),
                  circularStrokeCap: CircularStrokeCap.butt,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.lightGreen,
                ),
              ),
            ),
          ),
        ]),
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
