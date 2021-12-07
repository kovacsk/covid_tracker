import 'package:covid_tracker/common/data/repository/cases_repository.dart';
import 'package:injectable/injectable.dart';

abstract class SetFavoriteCountryUseCase {
  Future<void> execute(String favorite);
}

@Injectable(as: SetFavoriteCountryUseCase)
class SetFavoriteCountryUseCaseImpl implements SetFavoriteCountryUseCase {
  final CasesRepository _casesRepository;

  SetFavoriteCountryUseCaseImpl(this._casesRepository);

  @override
  Future<void> execute(String favorite) async {
    _casesRepository.setFavoriteCountries(favorite);
  }
}
