import 'package:dartz/dartz.dart';
import 'package:test/test.dart';

import '../environment.dart';
import '../failure.dart';
import '../service_locator.dart';
import '../symbols.dart';

void main() {
  configureDependencies(Env.test);
  late Symbols symbols;
  final preExistingCustomSymbolKey = 'custom.symbol';
  final preExistingCustomSymbolValue = '4321';
  final nonExistantSymbolKey = 'i.am.not.here';
  final firstFreeSymbolAddressValue =
      Symbols.customSymbolStartingVal.toString();

  setUp(() {
    symbols = Symbols();
  });

  group('put', () {
    test(
      'should put a symbol in the symbols table '
      'when the symbol key does not already exist',
      () async {
        //arrange
        final newLabelKey = 'new.label';
        final newLabelValue = '6';
        //act
        symbols.put(newLabelKey, newLabelValue);
        final failureOrSymbolValue = symbols.get(newLabelKey);
        //assert
        expect(failureOrSymbolValue, right(newLabelValue));
      },
    );
    test(
      'should put a symbol in the symbols table and not the '
      'affect Symbols internal custom symbol value counter when the '
      'symbol key does not already exist and is put in the Symbols table',
      () async {
        //arrange
        final newLabelKey = 'new.label';
        final newLabelValue = '6';
        final firstCustomSymbolKey = 'firstCustomSymbol';
        final unaffectedCustomSymbolVal = firstFreeSymbolAddressValue;
        //act
        symbols.put(newLabelKey, newLabelValue);
        final failureOrSymbolValue = symbols.get(firstCustomSymbolKey);
        //assert
        expect(failureOrSymbolValue, right(unaffectedCustomSymbolVal));
      },
    );

    test(
      'should return none '
      'when the symbol key does not already exist',
      () async {
        //arrange
        final newLabelKey = 'new.label';
        final newLabelValue = '6';
        //act
        final failure = symbols.put(newLabelKey, newLabelValue);
        //assert
        expect(failure, none());
      },
    );

    test(
      'should return an InvalidLabelFailure '
      'when the symbol key already exists',
      () async {
        //arrange
        //act
        symbols.put(preExistingCustomSymbolKey, preExistingCustomSymbolValue);
        final failureOrSymbolValue = symbols.put(
          preExistingCustomSymbolKey,
          preExistingCustomSymbolValue,
        );
        //assert
        expect(failureOrSymbolValue, some(InvalidLabelFailure()));
      },
    );
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
      'when Symbols already contains the custom key/pair value',
      () async {
        //arrange
        symbols.put(preExistingCustomSymbolKey, preExistingCustomSymbolValue);
        //act
        final failureOrSymbolValue = symbols.get(preExistingCustomSymbolKey);
        //assert
        expect(failureOrSymbolValue, right(preExistingCustomSymbolValue));
      },
    );

    test(
      'should place the new symbol in the symbols table, '
      'paired with the first free available symbol address value, '
      'and return that value,'
      'when Symbols does not exist and it is the first custom symbol',
      () async {
        //arrange
        //act
        final failureOrSymbolValue = symbols.get(nonExistantSymbolKey);
        //assert
        expect(failureOrSymbolValue, right(firstFreeSymbolAddressValue));
      },
    );

    test(
      'should place the new symbol in the symbols table, '
      'paired with the nth free available symbol address value, '
      'and return that value,'
      'when the symbol does not exist',
      () async {
        //arrange
        final thirdSymbolKey = 'third';
        final thirdFreeSymbolAddressValue = '18';
        symbols.get('first');
        symbols.get('second');
        //act
        final failureOrSymbolValue = symbols.get(thirdSymbolKey);
        //assert
        expect(failureOrSymbolValue, right(thirdFreeSymbolAddressValue));
      },
    );
  });
}
