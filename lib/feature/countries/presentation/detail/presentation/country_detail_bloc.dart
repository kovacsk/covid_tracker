import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/usecase/set_favorite_country_usecase.dart';
import 'package:covid_tracker/feature/countries/presentation/detail/data/usecase/get_favorite_country_check_usecase.dart';
import 'package:covid_tracker/feature/countries/presentation/detail/data/usecase/remove_favorite_country_usecase.dart';
import 'package:covid_tracker/feature/countries/presentation/detail/presentation/country_detail_event.dart';
import 'package:covid_tracker/feature/countries/presentation/detail/presentation/country_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CountryDetailBloc extends Bloc<CountryDetailEvent, CountryDetailState> {
  final GetFavoriteCountryCheckUseCase _getFavoriteCountryCheckUseCase;
  final SetFavoriteCountryUseCase _setFavoriteCountryUseCase;
  final RemoveFavoriteCountryUseCase _removeFavoriteCountryUseCase;

  bool _isFavorite = false;
  String _country = "";

  CountryDetailBloc(this._getFavoriteCountryCheckUseCase, this._setFavoriteCountryUseCase,
      this._removeFavoriteCountryUseCase)
      : super(CountryDetailInitial.initial()) {
    on<CountryDetailOnCreated>((event, emit) => _handleOnCreated(event, emit));
    on<CountryDetailOnFavoriteChanged>((event, emit) => _handleFavoriteChanged(event, emit));
  }

  Future<void> _handleFavoriteChanged(CountryDetailOnFavoriteChanged event, Emitter emit) async {
    _loadingWithCurrentState();
    _isFavorite = event.favorite;
    if (_isFavorite) {
      _setFavoriteCountryUseCase.execute(_country);
    } else {
      _removeFavoriteCountryUseCase.execute(_country);
    }
    emit(CountryDetailFavoriteChanged(_isFavorite));
    _loadedWithCurrentState();
  }

  Future<void> _handleOnCreated(CountryDetailOnCreated event, Emitter emit) async {
    _country = event.country;
    _isFavorite = await _getFavoriteCountryCheckUseCase.execute(_country);
    _loadedWithCurrentState();
  }

  CountryDetailInitial _loadedWithCurrentState() =>
      CountryDetailInitial.loaded(isFavorite: _isFavorite);

  CountryDetailInitial _loadingWithCurrentState() =>
      CountryDetailInitial.loading(isFavorite: _isFavorite);
}
