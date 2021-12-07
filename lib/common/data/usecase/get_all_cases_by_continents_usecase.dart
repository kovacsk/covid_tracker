import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/repository/cases_repository.dart';
import 'package:injectable/injectable.dart';

abstract class GetCasesByContinentsUseCase {
  Future<List<CompleteCases>> execute(String continent);
}

@Injectable(as: GetCasesByContinentsUseCase)
class GetCasesByContinentsUseCaseImpl implements GetCasesByContinentsUseCase {
  final CasesRepository _casesRepository;

  GetCasesByContinentsUseCaseImpl(this._casesRepository);

  @override
  Future<List<CompleteCases>> execute(String continent) {
    return _casesRepository.getAllCasesByContinents(continent);
  }
}
