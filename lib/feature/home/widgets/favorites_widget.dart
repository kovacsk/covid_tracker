import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Favorites extends StatelessWidget {
  final String countryName;
  final double casesPercentage;
  final double vaccinesPercentage;
  final String flagId;

  const Favorites(
      {Key? key,
      required this.countryName,
      required this.casesPercentage,
      required this.vaccinesPercentage,
      required this.flagId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white10),
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(countryName),
          ),
          if (flagId != "")
            Flag.fromString(
              flagId,
              width: 30,
              height: 30,
            ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircularPercentIndicator(
              radius: 50,
              center: Text((casesPercentage * 100).toInt().toString() + '%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0)),
              footer: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Cases confirmed"),
              ),
              animation: true,
              animationDuration: 1200,
              lineWidth: 10.0,
              percent: casesPercentage,
              circularStrokeCap: CircularStrokeCap.butt,
              backgroundColor: Colors.grey,
              progressColor: Colors.lightBlueAccent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircularPercentIndicator(
              radius: 50,
              center: Text(
                (vaccinesPercentage * 100).toInt().toString() + "%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),
              ),
              footer: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Vaccinated"),
              ),
              animation: true,
              animationDuration: 1200,
              lineWidth: 10.0,
              percent: vaccinesPercentage,
              circularStrokeCap: CircularStrokeCap.butt,
              backgroundColor: Colors.grey,
              progressColor: Colors.lightBlueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
