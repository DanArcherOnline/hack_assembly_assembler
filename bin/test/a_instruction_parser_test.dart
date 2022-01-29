import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import '../a_instruction_parser.dart';
import '../c_instruction_parser.dart';
import '../di_setup.dart';
import '../failure.dart';
import '../instruction.dart';

@GenerateMocks([AInstructionParser, CInstructionParser])
void main() {
  configureDependencies();
  late AInstructionParser aInstructionParser;
  late final aInstruction = AInstruction(value: '');

  setUp(() {
    aInstructionParser = sl<AInstructionParser>();
  });

  group('isValid', () {
    test(
      'should return true when first character '
      'is the ${AInstructionParser.aInstructionSymbol} symbol',
      () async {
        //arrange
        final code = '${AInstructionParser.aInstructionSymbol}8';
        //act
        final isValidAInstruction = aInstructionParser.isValid(code);
        //assert
        expect(isValidAInstruction, true);
      },
    );

    test(
      'should return false when first character '
      'is not the ${AInstructionParser.aInstructionSymbol} symbol',
      () async {
        //arrange
        final code = 'M=D-1';
        //act
        final isValidAInstruction = aInstructionParser.isValid(code);
        //assert
        expect(isValidAInstruction, false);
      },
    );
  });

  group('parse', () {
    test(
      'should return an AInstruction with its value '
      'when the value is within the maximum range',
      () async {
        //arrange
        final code = '@26';
        final expectedAInstruction = AInstruction(value: '26');
        //act
        final instruction = aInstructionParser.parse(code);
        //assert
        expect(instruction, right(expectedAInstruction));
      },
    );

    test(
      'should return a ValueTooLargeFailure '
      'when the value is beyond the maximum range',
      () async {
        //arrange
        final beyondMaxValCode = '@${AInstructionParser.maxVal + 1}';
        //act
        final failure = aInstructionParser.parse(beyondMaxValCode);
        //assert
        expect(failure, left(ValueTooLargeFailure()));
      },
    );
  });
}
