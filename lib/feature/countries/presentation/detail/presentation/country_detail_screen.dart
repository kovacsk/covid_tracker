import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/widgets/cases_detail.dart';
import 'package:covid_tracker/feature/countries/presentation/detail/presentation/country_detail_bloc.dart';
import 'package:covid_tracker/feature/countries/presentation/detail/presentation/country_detail_event.dart';
import 'package:covid_tracker/feature/countries/presentation/detail/presentation/country_detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CountryDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final country = ModalRoute.of(context)!.settings.arguments as CompleteCases;
    return BlocProvider(
      create: (_) => GetIt.I.get<CountryDetailBloc>()..add(CountryDetailOnCreated(country.country)),
      child: CountryDetailWidget(
        country: country,
      ),
    );
  }
}

class CountryDetailWidget extends StatefulWidget {
  final CompleteCases country;

  const CountryDetailWidget({Key? key, required this.country}) : super(key: key);

  @override
  _CountryDetailWidgetState createState() => _CountryDetailWidgetState(country);
}

class _CountryDetailWidgetState extends State<CountryDetailWidget> {
  final CompleteCases country;
  bool _isFavorite = false;
 _CountryDetailWidgetState(this.country);

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<CountryDetailBloc>();
    return BlocConsumer<CountryDetailBloc, CountryDetailState>(
        listener: (_, newState) {

        },
        listenWhen: (oldState, newState) => newState.isListenable(),
        buildWhen: (oldState, newState) => newState.isBuildable(),
        builder: (_, newState) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text(country.country),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Checkbox(
                      onChanged: (bool? value) {
                        setState(() {
                          _isFavorite = value!;
                        });
                      },
                      value: _isFavorite,
                    ),
                  )
                ],
              ),
              body: Column(
                children: [
                  CasesDetail(country),
                ],
              ),
            ),
          );
        });
  }
}
