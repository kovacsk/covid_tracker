import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';
import 'getit_root.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)


configureDependencies() => $initGetIt(getIt);

class DatasourceKeys{
  static const local = "local";
  static const remote = "remote";
}