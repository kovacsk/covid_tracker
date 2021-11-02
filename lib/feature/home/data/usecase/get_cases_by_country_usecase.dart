import 'package:covid_tracker/feature/home/data/repository/home_repository.dart';

import '../../../../model/json_models.dart';

abstract class GetAllVaccinatedUseCase {
  Future<Country> execute(String country);
}

class GetAllVaccinatedUseCaseImpl implements GetAllVaccinatedUseCase {
  final HomeRepository _homeRepository;

  GetAllVaccinatedUseCaseImpl(this._homeRepository);

  @override
  Future<Country> execute(String country) {
    return _homeRepository.getCasesByCountry(country);
  }
}
