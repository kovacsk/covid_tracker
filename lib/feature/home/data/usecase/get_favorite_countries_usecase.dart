import 'package:covid_tracker/feature/home/data/repository/home_repository.dart';

import '../../../../model/json_models.dart';

abstract class GetFavoriteCountriesUseCase {
  Future<List<Country>> execute();
}

class GetFavoriteCountriesUseCaseImpl implements GetFavoriteCountriesUseCase {
  final HomeRepository _homeRepository;

  GetFavoriteCountriesUseCaseImpl(this._homeRepository);

  @override
  Future<List<Country>> execute() {
    return _homeRepository.getFavoriteCountries();
  }
}
