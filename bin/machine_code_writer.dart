import 'dart:io';

import 'machine_code_instruction.dart';

class MachineCodeWriter {
  File file;
  MachineCodeWriter({
    required this.file,
  });

  void write(MachineCodeInstruction machineCodeInstruction) {
    file.writeAsStringSync(
      machineCodeInstruction.value + '\n',
      mode: FileMode.append,
    );
  }
}
