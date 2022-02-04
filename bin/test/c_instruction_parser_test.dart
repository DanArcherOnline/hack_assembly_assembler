import 'package:dartz/dartz.dart';
import 'package:test/test.dart';

import '../assembler/core/environment.dart';
import '../assembler/core/failure.dart';
import '../assembler/core/service_locator.dart';
import '../assembler/core/typedefs.dart';
import '../assembler/parsing/assembly_instruction.dart';
import '../assembler/parsing/c_instruction_parser.dart';

void main() {
  configureDependencies(Env.test);
  late CInstructionParser cInstructionParser;

  setUp(() {
    cInstructionParser = sl<CInstructionParser>();
  });

  group('isValid', () {
    test(
      'should return true when code matches with the CInstructions regex rules',
      () async {
        //arrange
        final code = 'D=M+1';
        //act
        final isValidCInstruction = cInstructionParser.isValid(code);
        //assert
        expect(isValidCInstruction, true);
      },
    );

    test(
      'should return false when code does not '
      'match with the CInstructions regex rules',
      () async {
        //arrange
        final invalidCode = 'D=M+Z';
        //act
        final isValidCInstruction = cInstructionParser.isValid(invalidCode);
        //assert
        expect(isValidCInstruction, false);
      },
    );
  });

  group(
    'parse',
    () {
      void instructionTableTest({
        required String code,
        required FailureOrInstruction expected,
      }) {
        test(
          'should return ${expected.toString()} '
          'when parsing assembly code "$code"',
          () async {
            //arrange
            //act
            final failureOrInstruction =
                cInstructionParser.parse(code: code, lineNumber: 0);
            //assert
            expect(
              failureOrInstruction,
              expected,
            );
          },
        );
      }

      //CInstructions
      instructionTableTest(
        code: 'D=M+1',
        expected: right(
          CInstruction(
            destination: 'D',
            computation: 'M+1',
            jump: null,
          ),
        ),
      );
      instructionTableTest(
        code: 'AM=M-1',
        expected: right(
          CInstruction(
            destination: 'AM',
            computation: 'M-1',
            jump: null,
          ),
        ),
      );
      instructionTableTest(
        code: 'D;JNE',
        expected: right(
          CInstruction(
            destination: null,
            computation: 'D',
            jump: 'JNE',
          ),
        ),
      );
      instructionTableTest(
        code: 'M+1',
        expected: right(
          CInstruction(
            destination: null,
            computation: 'M+1',
            jump: null,
          ),
        ),
      );

      //Failures
      instructionTableTest(
        code: 'Z=M+1',
        expected: left(
          InvalidCInstructionDestinationFailure(),
        ),
      );
      instructionTableTest(
        code: 'A"M=M-1',
        expected: left(InvalidCInstructionDestinationFailure()),
      );
      instructionTableTest(
        code: 'D JNE',
        expected: left(InvalidCInstructionComputationFailure()),
      );
      instructionTableTest(
        code: 'M+1; WHAT',
        expected: left(InvalidCInstructionJumpFailure()),
      );
    },
  );
}
