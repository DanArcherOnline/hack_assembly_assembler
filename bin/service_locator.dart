import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  generateForDir: ['bin'],
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies(Env env) {
  $initGetIt(sl, environment: env.name);
}

enum Env {
  dev,
  test,
}
