import 'package:file/file.dart';
import 'package:injectable/injectable.dart';

import '../core/failure.dart';
import '../translation/machine_code_instruction.dart';

@injectable
class MachineCodeWriter {
  static const asmFileExtension = '.asm';
  static const hackFileExtension = '.hack';

  final FileSystem fileSystem;
  late final File _fileOut;

  MachineCodeWriter({
    required this.fileSystem,
    @factoryParam required String? filePathIn,
  }) {
    if (filePathIn == null) {
      throw InvalidFilePathFailure();
    }
    if (!_isFileExtensionAsm(filePathIn)) {
      throw InvalidFilePathFailure();
    }
    final filePathOut = _convertAsmPathToHackPath(filePathIn);
    assert(_isFileExtensionHack(filePathOut));
    _fileOut = fileSystem.file(filePathOut);
    _fileOut.createSync(recursive: true);
  }

  bool _isFileExtensionHack(String filePathOut) {
    return filePathOut
            .substring(filePathOut.length - hackFileExtension.length)
            .length ==
        hackFileExtension.length;
  }

  String _convertAsmPathToHackPath(String? filePathIn) {
    return filePathIn!.replaceRange(
        filePathIn.length - asmFileExtension.length, null, hackFileExtension);
  }

  bool _isFileExtensionAsm(String? filePathIn) =>
      filePathIn!.substring(filePathIn.length - asmFileExtension.length) ==
      asmFileExtension;

  void write(MachineCodeInstruction machineCodeInstruction) {
    _fileOut.writeAsStringSync(
      machineCodeInstruction.value + '\n',
      mode: FileMode.append,
    );
  }

  File get file => _fileOut;
}
