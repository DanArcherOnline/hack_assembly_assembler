import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import '../a_instruction_parser.dart';
import '../c_instruction_parser.dart';
import '../di_setup.dart';
import '../failure.dart';
import '../instruction.dart';
import '../typedefs.dart';

@GenerateMocks([AInstructionParser, CInstructionParser])
void main() {
  configureDependencies();
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
            final failureOrInstruction = cInstructionParser.parse(code);
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
