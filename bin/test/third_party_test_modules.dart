import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ThirdPartyTestModules {
  @Environment('test')
  @lazySingleton
  FileSystem get memoryFileSystem => MemoryFileSystem();
}
