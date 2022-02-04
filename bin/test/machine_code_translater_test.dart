import 'package:dartz/dartz.dart';
import 'package:test/test.dart';

import '../assembler/core/environment.dart';
import '../assembler/core/failure.dart';
import '../assembler/core/service_locator.dart';
import '../assembler/core/typedefs.dart';
import '../assembler/parsing/a_instruction_parser.dart';
import '../assembler/parsing/assembly_instruction.dart';
import '../assembler/translation/machine_code_instruction.dart';
import '../assembler/translation/machine_code_translator.dart';

void main() {
  configureDependencies(Env.test);
  final machineCodeTranslator = sl<MachineCodeTranslator>();

  void translatorTableTest({
    required AssemblyInstruction assemblyInstruction,
    required FailureOrMachineCodeInstruction expected,
  }) {
    test(
      'should return $expected '
      'when translating assembly instruction "$assemblyInstruction"',
      () async {
        //arrange
        //act
        final failureOrMachineCodeInstruction =
            machineCodeTranslator.translate(assemblyInstruction);
        //assert
        expect(
          failureOrMachineCodeInstruction,
          expected,
        );
      },
    );
  }

  group('translate', () {
    //AInstruction
    final aInstruction1 = AInstruction(value: '14');
    translatorTableTest(
      assemblyInstruction: aInstruction1,
      expected: right(MachineCodeInstruction(value: '0000000000001110')),
    );

    final aInstruction2 = AInstruction(value: '2626');
    translatorTableTest(
      assemblyInstruction: aInstruction2,
      expected: right(MachineCodeInstruction(value: '0000101001000010')),
    );

    final notANumber = 'NaN';
    translatorTableTest(
      assemblyInstruction: AInstruction(value: notANumber),
      expected: left(InvalidAInstructionValueFailure()),
    );

    final beyondMaxValue = (AInstructionParser.maxVal + 1).toString();
    translatorTableTest(
      assemblyInstruction: AInstruction(value: (beyondMaxValue)),
      expected: left(ValueTooLargeFailure()),
    );

    //CInstruction
    final assignCInstruction1 = CInstruction(
      destination: 'D',
      computation: 'M',
      jump: null,
    );
    translatorTableTest(
      assemblyInstruction: assignCInstruction1,
      expected: right(MachineCodeInstruction(value: '1111110000010000')),
    );

    final assignCInstruction2 = CInstruction(
      destination: 'ADM',
      computation: 'A-D',
      jump: null,
    );
    translatorTableTest(
      assemblyInstruction: assignCInstruction2,
      expected: right(MachineCodeInstruction(value: '1110000111111000')),
    );

    final jumpCInstruction1 = CInstruction(
      destination: null,
      computation: '0',
      jump: 'JNE',
    );
    translatorTableTest(
      assemblyInstruction: jumpCInstruction1,
      expected: right(MachineCodeInstruction(value: '1110101010000101')),
    );

    final jumpCInstruction2 = CInstruction(
      destination: null,
      computation: '-A',
      jump: 'JGT',
    );
    translatorTableTest(
      assemblyInstruction: jumpCInstruction2,
      expected: right(MachineCodeInstruction(value: '1110110011000001')),
    );
    final onlyComputationCInstruction = CInstruction(
      destination: null,
      computation: 'D|M',
      jump: null,
    );
    translatorTableTest(
      assemblyInstruction: onlyComputationCInstruction,
      expected: right(MachineCodeInstruction(value: '1111010101000000')),
    );

    final emptyCInstruction = CInstruction(
      destination: null,
      computation: null,
      jump: null,
    );
    translatorTableTest(
      assemblyInstruction: emptyCInstruction,
      expected: left(InvalidCInstructionComputationFailure()),
    );

    final emptyComputationCInstruction = CInstruction(
      destination: 'D',
      computation: null,
      jump: 'JMP',
    );
    translatorTableTest(
      assemblyInstruction: emptyComputationCInstruction,
      expected: left(InvalidCInstructionComputationFailure()),
    );

    final invalidDestinationCInstruction = CInstruction(
      destination: 'INVALID',
      computation: 'D',
      jump: null,
    );
    translatorTableTest(
      assemblyInstruction: invalidDestinationCInstruction,
      expected: left(InvalidCInstructionDestinationFailure()),
    );

    final invalidComputationCInstruction = CInstruction(
      destination: null,
      computation: 'INVALID',
      jump: null,
    );
    translatorTableTest(
      assemblyInstruction: invalidComputationCInstruction,
      expected: left(InvalidCInstructionComputationFailure()),
    );

    final invalidJumpCInstruction = CInstruction(
      destination: null,
      computation: 'D',
      jump: 'FLY',
    );
    translatorTableTest(
      assemblyInstruction: invalidJumpCInstruction,
      expected: left(InvalidCInstructionJumpFailure()),
    );
  });
}
