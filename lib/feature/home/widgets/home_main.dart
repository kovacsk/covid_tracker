import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/model/country.dart';
import 'package:covid_tracker/common/data/model/vaccinated.dart';
import 'package:covid_tracker/feature/home/widgets/favorites_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeMain extends StatelessWidget {
  final CompleteCases country;
  final double vaccinated;
  final double cases;
  final List<CompleteCases> favoriteList;

  const HomeMain(
      {Key? key,
      required this.country,
      required this.vaccinated,
      required this.cases,
      required this.favoriteList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircularPercentIndicator(
              radius: 120,
              center: Text((cases * 100).toInt().toString() + '%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              footer: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Cases confirmed"),
              ),
              animation: true,
              animationDuration: 1200,
              lineWidth: 15.0,
              percent: cases,
              circularStrokeCap: CircularStrokeCap.butt,
              backgroundColor: Colors.grey,
              progressColor: Colors.lightBlueAccent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircularPercentIndicator(
              radius: 120,
              center: Text(
                (vaccinated * 100).toInt().toString() + "%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Vaccinated"),
              ),
              animation: true,
              animationDuration: 1200,
              lineWidth: 15.0,
              percent: vaccinated,
              circularStrokeCap: CircularStrokeCap.butt,
              backgroundColor: Colors.grey,
              progressColor: Colors.lightBlueAccent,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final item = favoriteList[index];
                  return Favorites(
                    vaccinesPercentage: item.toDoubleVaccinatedPercentage(),
                    casesPercentage: item.toDoubleConfirmedPercentage(),
                    countryName: item.country,
                    flagId: item.abbreviation,
                  );
                },
                itemCount: favoriteList.length,
                separatorBuilder: (_, index) => Divider(endIndent: 5,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
