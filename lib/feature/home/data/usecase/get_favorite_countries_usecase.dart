import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/repository/cases_repository.dart';
import 'package:injectable/injectable.dart';

abstract class GetFavoriteCountriesUseCase {
  Future<List<CompleteCases>> execute();
}

@Injectable(as: GetFavoriteCountriesUseCase)
class GetFavoriteCountriesUseCaseImpl implements GetFavoriteCountriesUseCase {
  final CasesRepository _casesRepository;

  GetFavoriteCountriesUseCaseImpl(this._casesRepository);

  @override
  Future<List<CompleteCases>> execute() {
    return _casesRepository.getFavoriteCountries();
  }
}
