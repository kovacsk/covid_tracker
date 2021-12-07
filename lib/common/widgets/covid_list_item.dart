import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CovidListItem extends StatelessWidget {
  final String countryName;
  final double casesPercentage;
  final double vaccinesPercentage;
  final String flagId;
  final String updated;
  final Function(bool) onTap;
  final bool isSelected;

  CovidListItem(
      {required this.countryName,
      required this.casesPercentage,
      required this.flagId,
      required this.updated,
      required this.vaccinesPercentage,
      required this.onTap,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Future.delayed(Duration(microseconds: 200));
        onTap(!isSelected);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PercentRowWidget(
              casesPercentage: casesPercentage, vaccinesPercentage: vaccinesPercentage),
          FlagWidget(countryName: countryName, flagId: flagId, updated: updated),
        ],
      ),
    );
  }
}

class PercentRowWidget extends StatelessWidget {
  final double casesPercentage;
  final double vaccinesPercentage;

  const PercentRowWidget({
    Key? key,
    required this.casesPercentage,
    required this.vaccinesPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularPercentIndicator(
          footer: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Cases"),
          ),
          radius: 50,
          percent: casesPercentage,
          center: Text((casesPercentage * 100).toInt().toString() + '%'),
          animation: true,
          animationDuration: 1200,
          circularStrokeCap: CircularStrokeCap.butt,
          backgroundColor: Colors.grey,
          progressColor: Colors.lightBlueAccent,
        ),
        CircularPercentIndicator(
          footer: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Vaccinated"),
          ),
          radius: 50,
          percent: vaccinesPercentage,
          center: Text((vaccinesPercentage * 100).toInt().toString() + '%'),
          animation: true,
          animationDuration: 1200,
          circularStrokeCap: CircularStrokeCap.butt,
          backgroundColor: Colors.grey,
          progressColor: Colors.lightBlueAccent,
        ),
      ],
    );
  }
}

class FlagWidget extends StatelessWidget {
  const FlagWidget({
    Key? key,
    required this.countryName,
    required this.flagId,
    required this.updated,
  }) : super(key: key);

  final String countryName;
  final String flagId;
  final String updated;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            countryName,
            softWrap: true,
            overflow: TextOverflow.clip,
          ),
          if (flagId != "")
            Flag.fromString(
              flagId,
              width: 50,
              height: 50,
            ),
          Text(
            updated,
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );
  }
}
