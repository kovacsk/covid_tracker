import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/usecase/get_all_cases_by_country_usecase.dart';
import 'package:covid_tracker/feature/home/data/usecase/get_favorite_countries_usecase.dart';
import 'package:covid_tracker/feature/home/presentation/home_event.dart';
import 'package:covid_tracker/feature/home/presentation/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCasesByCountryUseCase _getCasesByCountryUseCase;
  final GetFavoriteCountriesUseCase _getFavoriteCountriesUseCase;

  CompleteCases _country = CompleteCases.empty;
  double _vaccinatedPercentage = 0.0;
  double _casesPercentage = 0.0;
  List<CompleteCases> _favoriteCountries = List.empty();

  HomeBloc(this._getCasesByCountryUseCase, this._getFavoriteCountriesUseCase) : super(HomeInitial.initial()) {
    on<HomeOnCreated>((event, emit) => _handleOnCreated(emit));
  }

  Future<void> _handleOnCreated(Emitter<HomeState> emit) async {
    emit(_loadingWithCurrentState());
    _country = await _getCasesByCountryUseCase.execute("Global");
    _favoriteCountries = await _getFavoriteCountriesUseCase.execute();
    calculateVaccinatedPercentage();
    emit(_loadedWithCurrentState());
  }

  void calculateVaccinatedPercentage() {
    _vaccinatedPercentage = _country.toDoubleVaccinatedPercentage();
    _casesPercentage = _country.toDoubleConfirmedPercentage();
  }

  HomeInitial _loadedWithCurrentState() => HomeInitial.loaded(
      country: _country,
      vaccinatedPercentage: _vaccinatedPercentage,
      casesPercentage: _casesPercentage,
      favoriteCountries: _favoriteCountries);

  HomeInitial _loadingWithCurrentState() => HomeInitial.loading(
      country: _country,
      vaccinatedPercentage: _vaccinatedPercentage,
      casesPercentage: _casesPercentage,
      favoriteCountries: _favoriteCountries);
}
