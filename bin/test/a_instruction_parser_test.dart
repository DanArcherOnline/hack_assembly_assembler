import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../a_instruction_parser.dart';
import '../assembly_instruction.dart';
import '../environment.dart';
import '../failure.dart';
import '../service_locator.dart';
import '../symbols.dart';

@GenerateMocks([Symbols])
void main() {
  configureDependencies(Env.test);
  late AInstructionParser aInstructionParser;
  late Symbols symbols;

  setUp(() {
    symbols = sl<Symbols>();
    aInstructionParser = AInstructionParser(symbols: symbols);
  });

  group('isValid', () {
    test(
      'should return true when first character '
      'is the @ symbol',
      () async {
        //arrange
        final code = '@8';
        //act
        final isValidAInstruction = aInstructionParser.isValid(code);
        //assert
        expect(isValidAInstruction, true);
      },
    );

    test(
      'should return false when first character '
      'is not the @ symbol',
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
    //Values
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
      'should return an InvalidAInstructionValueFailure '
      'when the value is beyond the maximum range',
      () async {
        //arrange
        final beyondMaxValCode = '@${AInstructionParser.maxVal + 1}';
        //act
        final failure = aInstructionParser.parse(beyondMaxValCode);
        //assert
        expect(failure, left(InvalidAInstructionValueFailure()));
      },
    );

    //Symbols
    test(
      'should return an AInstruction with the value that corrasponds to '
      'the given key in Symbols when Symbols contains the given key/pair value',
      () async {
        //arrange
        final code = '@R15';
        final extractedCode = 'R15';
        final expectedAInstruction = AInstruction(value: '15');
        when(symbols.get(extractedCode)).thenAnswer((_) => right('15'));
        when(symbols.isValidKey(extractedCode)).thenAnswer((_) => true);
        //act
        final instruction = aInstructionParser.parse(code);
        //assert
        expect(instruction, right(expectedAInstruction));
      },
    );

    test(
      'should return a SymbolDoesNotExistFailure '
      'when the symbol given does not exist in Symbols',
      () async {
        //arrange
        final code = '@IShouldNotExist';
        final extractedCode = 'IShouldNotExist';
        when(symbols.get(extractedCode))
            .thenAnswer((_) => left(SymbolDoesNotExistFailure()));
        when(symbols.isValidKey(extractedCode)).thenAnswer((_) => true);

        //act
        final instruction = aInstructionParser.parse(code);
        //assert
        expect(instruction, left(SymbolDoesNotExistFailure()));
      },
    );

    test(
      'should return an InvalidAInstructionFailure '
      'when the symbol given starts with a non-alphabetical character',
      () async {
        //arrange
        final invalidSymbolCode = '@/IShouldNotExist';
        final invalidSymbolKey = '/IShouldNotExist';
        when(symbols.isValidKey(invalidSymbolKey)).thenAnswer((_) => false);
        //act
        final instruction = aInstructionParser.parse(invalidSymbolCode);
        //assert
        expect(instruction, left(InvalidAInstructionValueFailure()));
      },
    );
  });
}
