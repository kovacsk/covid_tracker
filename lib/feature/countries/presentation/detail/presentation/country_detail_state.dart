import 'package:covid_tracker/common/data/model/complete_cases.dart';

abstract class CountryDetailState {
  bool isListenable() => false;

  bool isBuildable() => !isListenable();
}

class CountryDetailInitial extends CountryDetailState {
  final bool isLoading;
  final bool isFavorite;

  CountryDetailInitial.initial()
      : isLoading = true,
        isFavorite = false,
        super();

  CountryDetailInitial.loading({required this.isFavorite})
      : isLoading = true,
        super();

  CountryDetailInitial.loaded({required this.isFavorite})
      : isLoading = false,
        super();
}

class CountryDetailFavoriteChanged extends CountryDetailState {
  final bool favorite;

  CountryDetailFavoriteChanged(this.favorite);

  @override
  bool isListenable() => true;

  @override
  bool isBuildable() => true;
}

class CountryDetailError extends CountryDetailState {
  final String error;

  CountryDetailError(this.error);

  @override
  bool isListenable() => true;
}
