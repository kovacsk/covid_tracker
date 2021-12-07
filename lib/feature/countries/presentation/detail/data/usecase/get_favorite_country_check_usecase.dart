import 'package:covid_tracker/common/data/model/complete_cases.dart';
import 'package:covid_tracker/common/data/repository/cases_repository.dart';
import 'package:injectable/injectable.dart';

abstract class GetFavoriteCountryCheckUseCase {
  Future<bool> execute(String favorite);
}

@Injectable(as: GetFavoriteCountryCheckUseCase)
class GetFavoriteCountryCheckUseCaseImpl implements GetFavoriteCountryCheckUseCase {
  final CasesRepository _casesRepository;

  GetFavoriteCountryCheckUseCaseImpl(this._casesRepository);

  @override
  Future<bool> execute(String favorite) {
    return _casesRepository.getFavoriteCountryCheck(favorite);
  }
}
