import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/widgets/covid_list_item.dart';
import 'package:covid_tracker/feature/continents/data/model/continents.dart';
import 'package:covid_tracker/feature/continents/presentation/continents_state.dart';
import 'package:covid_tracker/feature/countries/navigation/countries_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'continents_bloc.dart';
import 'continents_event.dart';

class ContinentsScreen extends StatelessWidget {
  const ContinentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I.get<ContinentsBloc>()..add(ContinentsOnCreated()),
      child: ContinentsWidget(),
    );
  }
}

class ContinentsWidget extends StatefulWidget {
  const ContinentsWidget({Key? key}) : super(key: key);

  @override
  _ContinentsWidgetState createState() => _ContinentsWidgetState();
}

class _ContinentsWidgetState extends State<ContinentsWidget> {
  var _initialDropdownValue = Continents.europe;
  int? _selectedItemId;

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<ContinentsBloc>();
    return BlocConsumer<ContinentsBloc, ContinentsState>(
        listener: (_, newState) {},
        listenWhen: (oldState, newState) => newState.isListenable(),
        buildWhen: (oldState, newState) => !newState.isListenable(),
        builder: (_, newState) {
          final List<CompleteCases> _cases =
              newState is ContinentsInitial ? newState.countryList : List.empty();
          return Scaffold(
            appBar: AppBar(
              title: Text(""),
            ),
            body: Column(children: [
              DropdownButton<Continents>(
                value: _initialDropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black87),
                underline: Container(
                  height: 2,
                  color: Colors.black87,
                ),
                onChanged: (Continents? newValue) {
                  setState(() {
                    _bloc..add(ContinentsDropdownChanged(newValue!));
                    _initialDropdownValue = newValue;
                  });
                },
                items: <Continents>[
                  Continents.europe,
                  Continents.asia,
                  Continents.africa,
                  Continents.south_america,
                  Continents.north_america,
                  Continents.oceania
                ].map<DropdownMenuItem<Continents>>((Continents value) {
                  return DropdownMenuItem<Continents>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    final item = _cases[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CovidListItem(
                        onTap: (bool isSelected) {
                          setState(() {
                            if (isSelected) {
                              _selectedItemId = index;
                              CountriesNavigation.pushCountryDetail(context, item);
                            } else {
                              _selectedItemId = null;
                            }
                          });
                        },
                        isSelected: index == _selectedItemId,
                        countryName: item.country,
                        casesPercentage: item.toDoubleConfirmedPercentage(),
                        flagId: item.abbreviation,
                        updated: item.updated,
                        vaccinesPercentage: item.toDoubleVaccinatedPercentage(),
                      ),
                    );
                  },
                  separatorBuilder: (_, index) => Divider(),
                  itemCount: _cases.length,
                ),
              ),
            ]),
          );
        });
  }
}
