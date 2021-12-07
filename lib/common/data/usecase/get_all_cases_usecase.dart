import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/repository/cases_repository.dart';
import 'package:injectable/injectable.dart';

abstract class GetAllCasesUseCase {
  Future<List<CompleteCases>> execute();
}
@Injectable(as: GetAllCasesUseCase)
class GetAllCasesUseCaseImpl implements GetAllCasesUseCase {
  final CasesRepository _casesRepository;

  GetAllCasesUseCaseImpl(this._casesRepository);

  @override
  Future<List<CompleteCases>> execute() {
    return _casesRepository.getAllCasesByCountry();
  }
}
