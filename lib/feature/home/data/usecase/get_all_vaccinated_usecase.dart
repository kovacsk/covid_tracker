import 'package:covid_tracker/feature/home/data/repository/home_repository.dart';

import '../../../../model/json_models.dart';

abstract class GetAllVaccinatedUseCase {
  Future<Map<String, Vaccinated>> execute();
}

class GetAllVaccinatedUseCaseImpl implements GetAllVaccinatedUseCase {
  final HomeRepository _homeRepository;

  GetAllVaccinatedUseCaseImpl(this._homeRepository);

  @override
  Future<Map<String, Vaccinated>> execute() {
    return _homeRepository.getAllVaccinated();
  }
}
