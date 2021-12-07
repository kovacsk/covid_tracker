import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/widgets/covid_list_item.dart';
import 'package:covid_tracker/feature/countries/navigation/countries_navigation.dart';
import 'package:covid_tracker/feature/countries/presentation/countries_bloc.dart';
import 'package:covid_tracker/feature/countries/presentation/countries_event.dart';
import 'package:covid_tracker/feature/countries/presentation/countries_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CountriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I.get<CountriesBloc>()..add(CountriesOnCreated()),
      child: CountriesWidget(),
    );
  }
}

class CountriesWidget extends StatefulWidget {
  const CountriesWidget({Key? key}) : super(key: key);

  @override
  _CountriesWidgetState createState() => _CountriesWidgetState();
}

class _CountriesWidgetState extends State<CountriesWidget> {
  int? _selectedItemId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CountriesBloc, CountriesState>(
        listener: (_, newState) {},
        listenWhen: (oldState, newState) => newState.isListenable(),
        buildWhen: (oldState, newState) => !newState.isListenable(),
        builder: (_, newState) {
          final List<CompleteCases> _cases =
              newState is CountriesInitial ? newState.countryList : List.empty();
          return Scaffold(
            appBar: AppBar(
              title: Text("Countries"),
            ),
            body: Column(children: [
              TextField(),
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
                              CountriesNavigation.pushCountryDetail(
                                  context, item);
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
