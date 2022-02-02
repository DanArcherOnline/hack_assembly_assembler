import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ThirdPartyModules {
  @dev
  @lazySingleton
  FileSystem get localFileSystem => LocalFileSystem();
}
