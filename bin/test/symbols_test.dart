import 'package:dartz/dartz.dart';
import 'package:test/test.dart';

import '../environment.dart';
import '../failure.dart';
import '../service_locator.dart';
import '../symbols.dart';

void main() {
  configureDependencies(Env.test);
  late Symbols symbols;
  final customSymbolKey = 'custom.symbol';
  final customSymbolValue = '4321';
  final nonExistantSymbolKey = 'i.am.not.here';

  setUpAll(() {
    symbols = Symbols();
    symbols.put(customSymbolKey, customSymbolValue);
  });

  group('get', () {
    test(
      'should return the value of the given key '
      'when the key is a pre built-in symbol',
      () async {
        //arrange
        final existingKey = 'R0';
        final expectedValue = '0';
        //act
        final failureOrSymbolValue = symbols.get(existingKey);
        //assert
        expect(failureOrSymbolValue, right(expectedValue));
      },
    );

    test(
      'should return the value of the given key '
      'when Symbols contains the custom key/pair value',
      () async {
        //arrange
        //act
        final failureOrSymbolValue = symbols.get(customSymbolKey);
        //assert
        expect(failureOrSymbolValue, right(customSymbolValue));
      },
    );

    test(
      'should return SymbolDoesNotExistFailure '
      'when Symbols do not exist',
      () async {
        //arrange
        //act
        final failureOrSymbolValue = symbols.get(nonExistantSymbolKey);
        //assert
        expect(failureOrSymbolValue, left(SymbolDoesNotExistFailure()));
      },
    );
  });

  group('put', () {
    test(
      'should put a symbol in the symbol map '
      'when the symbol key does not already exist',
      () async {
        //arrange
        final newSymbolKey = 'newGuy';
        final newSymbolValue = '987';
        //act
        symbols.put(newSymbolKey, newSymbolValue);
        final failureOrSymbolValue = symbols.get(newSymbolKey);
        //assert
        expect(failureOrSymbolValue, right(newSymbolValue));
      },
    );

    test(
      'should not do anything '
      'when the symbol key already exists',
      () async {
        //arrange
        //act
        void putFunc() => symbols.put(customSymbolKey, customSymbolValue);
        final failureOrSymbolValue = symbols.get(customSymbolKey);
        //assert
        expect(putFunc, isNot(throwsA(anything)));
        expect(failureOrSymbolValue, right(customSymbolValue));
      },
    );
  });
}
