import 'package:test/test.dart';

import '../assembler/core/environment.dart';
import '../assembler/core/error_parser.dart';
import '../assembler/core/failure.dart';
import '../assembler/core/service_locator.dart';

void main() {
  configureDependencies(Env.test);
  late ErrorParser errorParser;

  setUp(() {
    errorParser = sl<ErrorParser>();
  });
  test(
    'should return correct message when given an InvalidLabelFailure '
    'of type unimplementedLabel ',
    () async {
      //arrange
      final failure = InvalidLabelFailure(
        type: InvalidLabelType.unimplementedLabel,
        lineNumber: 1,
        line: '(TEST_GUY)',
      );
      final expectedMessage = '''Line 1: Invalid Label.
The label was defined but never given any implementation.
------
(TEST_GUY)
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an InvalidLabelFailure '
    'of type invalidSyntax ',
    () async {
      //arrange
      final failure = InvalidLabelFailure(
        type: InvalidLabelType.invalidSyntax,
        lineNumber: 1,
        line: '(7EST_GUY)',
      );
      final expectedMessage = '''Line 1: Invalid Label.
Labels must start with an alphabetical character.
------
(7EST_GUY)
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an InvalidLabelFailure '
    'of type alreadyExists ',
    () async {
      //arrange
      final failure = InvalidLabelFailure(
        type: InvalidLabelType.alreadyExists,
        lineNumber: 17,
        line: '(TEST_GUY)',
      );
      final expectedMessage = '''Line 17: Invalid Label.
There are duplicate labels. Change one of the labels names.
------
(TEST_GUY)
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an InvalidFilePathFailure '
    'of type invalidFileExtension ',
    () async {
      //arrange
      final failure = InvalidFilePathFailure(
        type: InvalidFilePathType.invalidFileExtension,
        lineNumber: -1,
        line: '',
      );
      final expectedMessage =
          '''The file specified does not have the file extension ".asm"
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an InvalidCInstructionJumpFailure '
    'of type invalidSyntax ',
    () async {
      //arrange
      final failure = InvalidCInstructionJumpFailure(
        type: InvalidCInstructionJumpType.invalidSyntax,
        lineNumber: 6,
        line: '0;JMO',
      );
      final expectedMessage = '''Line 6: Invalid C Instruction
The Jump command in the code below does not exist.
Choose a Jump command from the following: null, JGT, JEQ, JGE, JLT, JNE, JLE, JMP
------
0;JMO
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an InvalidCInstructionJumpFailure '
    'of type notFound ',
    () async {
      //arrange
      final failure = InvalidCInstructionJumpFailure(
        type: InvalidCInstructionJumpType.notFound,
        lineNumber: 6,
        line: '0;JMO',
      );
      final expectedMessage = '''Line 6: Invalid C Instruction
The Jump command in the code below does not exist.
Choose a Jump command from the following: null, JGT, JEQ, JGE, JLT, JNE, JLE, JMP
------
0;JMO
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an InvalidCInstructionComputationFailure '
    'of type invalidSyntax ',
    () async {
      //arrange
      final failure = InvalidCInstructionComputationFailure(
        type: InvalidCInstructionComputationType.invalidSyntax,
        lineNumber: 2,
        line: 'D=A--',
      );
      final expectedMessage = '''Line 2: Invalid C Instruction
The Computation command in the code below does not exist.
Choose a Computation command from the following: 0, 1, -1, D, A, !D, !A, -D, -A, D+1, A+1, D-1, A-1, D+A, A+D, D-A, A-D, D&A, A&D, D|A, A|D, M, !M, -M, M+1, M-1, D+M, M+D, D-M, M-D, D&M, M&D, D|M, M|D
------
D=A--
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an InvalidCInstructionComputationFailure '
    'of type notFound ',
    () async {
      //arrange
      final failure = InvalidCInstructionComputationFailure(
        type: InvalidCInstructionComputationType.notFound,
        lineNumber: 2,
        line: 'D=A--',
      );
      final expectedMessage = '''Line 2: Invalid C Instruction
The Computation command in the code below does not exist.
Choose a Computation command from the following: 0, 1, -1, D, A, !D, !A, -D, -A, D+1, A+1, D-1, A-1, D+A, A+D, D-A, A-D, D&A, A&D, D|A, A|D, M, !M, -M, M+1, M-1, D+M, M+D, D-M, M-D, D&M, M&D, D|M, M|D
------
D=A--
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an InvalidCInstructionDestinationFailure '
    'of type invalidSyntax ',
    () async {
      //arrange
      final failure = InvalidCInstructionDestinationFailure(
        type: InvalidCInstructionDestinationType.invalidSyntax,
        lineNumber: 2,
        line: 'DD=A',
      );
      final expectedMessage = '''Line 2: Invalid C Instruction
The Destination in the code below does not exist.
Choose a Computation command from the following: null, M, D, DM, MD, A, AM, MA, AD, DA, ADM, AMD, DAM, DMA, MAD, MDA
------
DD=A
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an InvalidCInstructionDestinationFailure '
    'of type notFound ',
    () async {
      //arrange
      final failure = InvalidCInstructionDestinationFailure(
        type: InvalidCInstructionDestinationType.notFound,
        lineNumber: 2,
        line: 'DD=A',
      );
      final expectedMessage = '''Line 2: Invalid C Instruction
The Destination in the code below does not exist.
Choose a Computation command from the following: null, M, D, DM, MD, A, AM, MA, AD, DA, ADM, AMD, DAM, DMA, MAD, MDA
------
DD=A
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an InvalidAInstructionValueFailure '
    'of type valueTooLarge ',
    () async {
      //arrange
      final failure = InvalidAInstructionValueFailure(
        type: InvalidAInstructionValueType.valueTooLarge,
        lineNumber: 3,
        line: '@9999999999999',
      );
      final expectedMessage = '''Line 3: Invalid A Instruction
The value in the code below exceeds the maximum value of 1000000
------
@9999999999999
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an InvalidAInstructionValueFailure '
    'of type noValue ',
    () async {
      //arrange
      final failure = InvalidAInstructionValueFailure(
        type: InvalidAInstructionValueType.noValue,
        lineNumber: 3,
        line: '@',
      );
      final expectedMessage = '''Line 3: Invalid A Instruction
There was no value given after the "@" character.
------
@
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an InvalidAInstructionValueFailure '
    'of type notANumber ',
    () async {
      //arrange
      final failure = InvalidAInstructionValueFailure(
        type: InvalidAInstructionValueType.notANumber,
        lineNumber: 3,
        line: '@99999999999999999999999999',
      );
      final expectedMessage = '''Line 3: Invalid A Instruction
The value specified after the "@" character was expected to be a number but was not.
It is possible that the value given was too large for the system to handle.
------
@99999999999999999999999999
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an InvalidAInstructionValueFailure '
    'of type invalidSymbolSyntax ',
    () async {
      //arrange
      final failure = InvalidAInstructionValueFailure(
        type: InvalidAInstructionValueType.invalidSymbolSyntax,
        lineNumber: 3,
        line: '@_yo',
      );
      final expectedMessage = '''
Line 3: Invalid A Instruction
Symbols must start with an alphabetical character.
------
@_yo
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return correct message when given an NotInstructionFailure '
    'of type invalidSyntax ',
    () async {
      //arrange
      final failure = NotInstructionFailure(
        type: NotInstructionType.invalidSyntax,
        lineNumber: 3,
        line: 'HI_MUM',
      );
      final expectedMessage = '''Line 3: Invalid Syntax
The code below was not valid syntax for an A Instruction or C Instruction
------
HI_MUM
''';
      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, expectedMessage);
    },
  );
  test(
    'should return null when given an NotInstructionFailure '
    'of type validNonCode ',
    () async {
      //arrange
      final failure = NotInstructionFailure(
        type: NotInstructionType.validNonCode,
        lineNumber: 3,
        line: '//for example, a comment',
      );

      //act
      final message = errorParser.parse(failure: failure);
      //assert
      expect(message, null);
    },
  );
}
