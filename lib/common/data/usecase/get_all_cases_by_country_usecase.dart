import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/repository/cases_repository.dart';
import 'package:injectable/injectable.dart';

abstract class GetCasesByCountryUseCase {
  Future<CompleteCases> execute(String country);
}

@Injectable(as: GetCasesByCountryUseCase)
class GetCasesByCountryUseCaseImpl implements GetCasesByCountryUseCase {
  final CasesRepository _casesRepository;

  GetCasesByCountryUseCaseImpl(this._casesRepository);

  @override
  Future<CompleteCases> execute(String country) {
    return _casesRepository.getCasesByCountry(country);
  }
}
