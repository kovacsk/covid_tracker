import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/model/country.dart';
import 'package:covid_tracker/common/data/model/country.dart';
import 'package:covid_tracker/feature/home/presentation/home_bloc.dart';
import 'package:covid_tracker/feature/home/presentation/home_event.dart';
import 'package:covid_tracker/feature/home/presentation/home_state.dart';
import 'package:covid_tracker/feature/home/widgets/favorites_widget.dart';
import 'package:covid_tracker/feature/home/widgets/home_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I.get<HomeBloc>()..add(HomeOnCreated()),
      child: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        listener: (_, newState) {},
        listenWhen: (oldState, newState) => newState.isListenable(),
        buildWhen: (oldState, newState) => !newState.isListenable(),
        builder: (_, newState) {
          final _country = newState is HomeInitial ? newState.country : CompleteCases.empty;
          final _vaccinated = newState is HomeInitial ? newState.vaccinatedPercentage : 0.0;
          final _cases = newState is HomeInitial ? newState.casesPercentage : 0.0;
          final _favorites = newState is HomeInitial ? newState.favoriteCountries : List<CompleteCases>.empty();
          return Scaffold(
            appBar: AppBar(
              title: Text("title"),
            ),
            body: (newState is HomeInitial && _country.country.isEmpty)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HomeMain(
                        country: _country,
                        vaccinated: _vaccinated,
                        cases: _cases,
                        favoriteList: _favorites,
                      )
                    ],
                  )
                : null,
          );
        });
  }
}
