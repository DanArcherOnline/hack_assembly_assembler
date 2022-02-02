import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:injectable/injectable.dart';

import '../environment.dart';
import '../symbols.dart';
import 'a_instruction_parser_test.mocks.dart';

@module
abstract class ThirdPartyTestModules {
  @tests
  @lazySingleton
  FileSystem get memoryFileSystem => MemoryFileSystem();

  @tests
  @injectable
  Symbols get symbols => MockSymbols();
}
