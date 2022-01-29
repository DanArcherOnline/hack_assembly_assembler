import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di_setup.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  generateForDir: ['bin', 'test'],
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => $initGetIt(sl);
