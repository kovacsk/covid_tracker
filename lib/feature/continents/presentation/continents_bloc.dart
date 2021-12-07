import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/usecase/get_all_cases_by_continents_usecase.dart';
import 'package:covid_tracker/feature/continents/data/model/continents.dart';
import 'package:covid_tracker/feature/continents/presentation/continents_event.dart';
import 'package:covid_tracker/feature/continents/presentation/continents_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ContinentsBloc extends Bloc<ContinentsEvent, ContinentsState> {
  final GetCasesByContinentsUseCase _getCasesByContinentsUseCase;

  List<CompleteCases> _countryList = List.empty();

  ContinentsBloc(this._getCasesByContinentsUseCase) : super(ContinentsInitial.initial()) {
    on<ContinentsOnCreated>((event, emit) => _handleOnCreated(emit));
    on<ContinentsDropdownChanged>((event, emit) => _handleDropdownChanged(event, emit));
  }

  Future<void> _handleOnCreated(Emitter<ContinentsState> emit) async {
    emit(ContinentsInitial.loading(countryList: _countryList));
    _countryList = await _getCasesByContinentsUseCase.execute("Europe");
    emit(ContinentsInitial.loaded(countryList: _countryList));
  }

  Future<void> _handleDropdownChanged(ContinentsDropdownChanged event, Emitter<ContinentsState> emit) async {
    emit(ContinentsInitial.loading(countryList: _countryList));
    _countryList = await _getCasesByContinentsUseCase.execute((event.newContinent).name);
    emit(ContinentsInitial.loaded(countryList: _countryList));
  }
}
