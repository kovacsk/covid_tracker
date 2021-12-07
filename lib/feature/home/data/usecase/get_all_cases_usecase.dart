import 'package:covid_tracker/feature/home/data/repository/home_repository.dart';

import '../../../../model/json_models.dart';

abstract class GetAllCasesUseCase {
  Future<Map<String, Country>> execute();
}

class GetAllCasesUseCaseImpl implements GetAllCasesUseCase {
  final HomeRepository _homeRepository;

  GetAllCasesUseCaseImpl(this._homeRepository);

  @override
  Future<Map<String, Country>> execute() {
    return _homeRepository.getAllCases();
  }
}
