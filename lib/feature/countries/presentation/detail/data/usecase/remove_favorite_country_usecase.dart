import 'package:covid_tracker/common/data/repository/cases_repository.dart';
import 'package:injectable/injectable.dart';

abstract class RemoveFavoriteCountryUseCase {
  Future<void> execute(String favorite);
}

@Injectable(as: RemoveFavoriteCountryUseCase)
class SetFavoriteCountryUseCaseImpl implements RemoveFavoriteCountryUseCase {
  final CasesRepository _casesRepository;

  SetFavoriteCountryUseCaseImpl(this._casesRepository);

  @override
  Future<void> execute(String favorite) async {
    _casesRepository.removeFavoriteCountry(favorite);
  }
}
