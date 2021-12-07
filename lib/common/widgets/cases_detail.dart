import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:flutter/cupertino.dart';

class CasesDetail extends StatelessWidget {
  final CompleteCases cases;

  CasesDetail(this.cases);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(cases.country),
        Text(cases.abbreviation),
        Text(cases.vaccinated.toString()),
        Text(cases.partiallyVaccinated.toString()),
        Text(cases.updated),
        Text(cases.recovered.toString()),
        Text(cases.location),
        Text(cases.deaths.toString()),
        Text(cases.confirmed.toString()),
        Text(cases.population.toString()),
        Text(cases.continent),
        Text(cases.iso.toString()),
      ],
    );
  }
}
