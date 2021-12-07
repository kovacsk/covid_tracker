
import 'package:flutter/cupertino.dart';

@immutable
abstract class CountryDetailEvent {}

class CountryDetailOnCreated extends CountryDetailEvent {
  final String country;

  CountryDetailOnCreated(this.country);
}

class CountryDetailOnFavoriteChanged extends CountryDetailEvent {
  final bool favorite;

  CountryDetailOnFavoriteChanged(this.favorite);
}
