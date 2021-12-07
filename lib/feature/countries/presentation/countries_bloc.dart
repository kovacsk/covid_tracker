import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/usecase/get_all_cases_usecase.dart';
import 'package:covid_tracker/feature/countries/presentation/countries_event.dart';
import 'package:covid_tracker/feature/countries/presentation/countries_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final GetAllCasesUseCase _getCasesByCountriesUseCase;

  List<CompleteCases> _countryList = List.empty();

  CountriesBloc(this._getCasesByCountriesUseCase) : super(CountriesInitial.initial()) {
    on<CountriesOnCreated>((event, emit) => _handleOnCreated(emit));
    on<CountriesOnSearched>((event, emit) => _handleOnSearched(event,emit));
  }

  Future<void> _handleOnCreated(Emitter<CountriesState> emit) async {
    emit(CountriesInitial.loading(countryList: _countryList));
    _countryList = await _getCasesByCountriesUseCase.execute();
    emit(CountriesInitial.loaded(countryList: _countryList));
  }

  Future<void> _handleOnSearched(CountriesOnSearched event, Emitter<CountriesState> emit) async {

  }


}
