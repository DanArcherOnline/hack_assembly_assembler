import 'package:file/memory.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../assembler/core/environment.dart';
import '../assembler/core/service_locator.dart';
import '../assembler/io/machine_code_writer.dart';
import '../assembler/translation/machine_code_instruction.dart';

void main() {
  configureDependencies(Env.test);
  const filePathIn = '/test/path/test_file.asm';
  final writer = sl.get<MachineCodeWriter>(param1: filePathIn);

  group('write', () {
    test(
      'should create a file when has completed its computation',
      () async {
        //arrange
        final machineCodeInstruction =
            MachineCodeInstruction(value: '1010101010101010');
        //act
        writer.write(machineCodeInstruction);
        //assert
        expect(writer.file.existsSync(), true);
      },
    );
    test(
      'should give its file the same path/file name as the given '
      'path/file name but with the .hack extension when instantiated',
      () async {
        //arrange
        final machineCodeInstruction =
            MachineCodeInstruction(value: '1010101010101010');
        //act
        writer.write(machineCodeInstruction);
        //assert
        expect(writer.file.existsSync(), true);
        expect(writer.file.path, '/test/path/test_file.hack');
      },
    );

    test(
      'should give its file the same path/file name as the given '
      'path/file name but with the .hack extension even when '
      'the given file path contains .asm somewhere else in the path',
      () async {
        //arrange
        const filePathIn = '/test/path/test.asm_file.asm';
        final testWriter = sl.get<MachineCodeWriter>(param1: filePathIn);

        final machineCodeInstruction =
            MachineCodeInstruction(value: '1010101010101010');
        //act
        testWriter.write(machineCodeInstruction);
        //assert
        expect(testWriter.file.existsSync(), true);
        expect(testWriter.file.path, '/test/path/test.asm_file.hack');
      },
    );

    test(
      'should throw an InvalidFilePathFailure when filePathIn is null',
      () async {
        //arrange
        //act
        //assert
        expect(
            () => MachineCodeWriter(
                fileSystem: MemoryFileSystem(), filePathIn: null),
            throwsA(isA<Exception>()));
      },
    );

    test(
      'should throw an InvalidFilePathFailure when the file given is not an .asm file',
      () async {
        //arrange
        const nonAsmFilePathIn = '/test/path/test.asm_file.js';
        //act
        //assert
        expect(
            () => MachineCodeWriter(
                fileSystem: MemoryFileSystem(), filePathIn: nonAsmFilePathIn),
            throwsA(isA<Exception>()));
      },
    );
  });
}
