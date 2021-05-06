import 'package:covid_tracker/repositories/network_repository.dart';
import 'package:covid_tracker/details/vaccine_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../details/country_detail_page.dart';
import '../model/json_models.dart';

class VaccinePage extends StatefulWidget {
@override
_VaccinePageState createState() => _VaccinePageState();
}

class _VaccinePageState extends State<VaccinePage> {
  final repository = NWRepository();
  late Future<Map<String, Vaccinated>> allVaccines;
  String sortBy = "Cases";
  @override
  void initState() {
    super.initState();
    allVaccines = repository.getAllVaccinated();
  }
  String dropdownValue = 'Vaccinated';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          var request = repository.getAllVaccinated();
          setState(() {
            allVaccines = request;
          });
          await request;
        },
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                        color: Colors.black87
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.black87,
                    ),
                    onChanged: (String? newValue) async {
                      var request = repository.getAllVaccinated();
                      setState(() {
                        dropdownValue = newValue!;
                        allVaccines = request;

                      });
                    },
                    items: <String>['Vaccinated', 'Partially vaccinated']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                        .toList(),
                  ),
                ]),
              ),
            ]),
            Expanded(
              child: SizedBox(
                child: FutureBuilder<Map<String, Vaccinated>>(
                    future: allVaccines,
                    builder: (context, snapshot) {
                      if (snapshot.hasError){
                        return Center(
                          child: Text(
                              "Hiba történt: ${snapshot.error}"
                          ),
                        );
                      } else if (snapshot.hasData){
                        var countryDetails = snapshot.data;
                        var list = countryDetails!.entries.toList();
                        if(dropdownValue == "Vaccinated"){
                          list.sort((b,a) => a.value.vaccinatedData.people_vaccinated!.compareTo(b.value.vaccinatedData.people_vaccinated!));
                        }
                        else if(dropdownValue == "Partially vaccinated"){
                          list.sort((b,a) => a.value.vaccinatedData.people_partially_vaccinated!.compareTo(b.value.vaccinatedData.people_partially_vaccinated!));
                        }
                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, i){
                            return new GestureDetector(
                              onTap: () =>
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => VaccineDetailPageWidget(countryName: list[i].key,))
                                  )
                              ,
                              child: ListItem(
                                list[i].value, name: list[i].key,
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
                    }
                ),
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
  final Vaccinated item;

  const ListItem(this.item, {Key? key, required this.name,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        child: Row(
          children: [Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Vaccinated: "+item.vaccinatedData.people_vaccinated.toString(),
                textAlign: TextAlign.start,
              ),
              Text(
                "Parcially vaccinated: "+ item.vaccinatedData.people_partially_vaccinated.toString(),
                textAlign: TextAlign.start,
              )

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
                      (_calcPercent()*100).toInt().toString()+"%",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    footer: Text(
                      "Vaccinated",
                      style: TextStyle(fontSize: 10),
                    ),
                    animation: true,
                    animationDuration: 1200,
                    lineWidth: 10.0,
                    percent: _calcPercent() ,
                    circularStrokeCap: CircularStrokeCap.butt,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.lightGreen,

                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularPercentIndicator(
                    radius: 50.0,
                    center: Text(
                      (_calcPartialliPercent()*100).toInt().toString()+"%",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    footer: Text(
                      "Partially",
                      style: TextStyle(fontSize: 10),
                    ),
                    animation: true,
                    animationDuration: 1200,
                    lineWidth: 10.0,
                    percent: _calcPartialliPercent() ,
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

  double _calcPartialliPercent(){
    if(item.vaccinatedData.people_partially_vaccinated != null && item.vaccinatedData.population != null){
      return (item.vaccinatedData.people_partially_vaccinated!.toDouble() / item.vaccinatedData.population!.toDouble()).toDouble();
    }else{
      return 0.0;
    }

  }

  double _calcPercent(){
    if(item.vaccinatedData.people_vaccinated != null && item.vaccinatedData.population != null){
      return (item.vaccinatedData.people_vaccinated!.toDouble() / item.vaccinatedData.population!.toDouble()).toDouble();
    }else{
      return 0.0;
    }

  }
}
  

