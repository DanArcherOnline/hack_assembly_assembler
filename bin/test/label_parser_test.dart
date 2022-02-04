import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../environment.dart';
import '../failure.dart';
import '../label_parser.dart';
import '../service_locator.dart';
import '../symbols.dart';

void main() {
  configureDependencies(Env.test);
  late LabelParser labelParser;
  late Symbols symbols;

  setUp(() {
    symbols = sl<Symbols>();
    labelParser = LabelParser(symbols: symbols);
  });
  group('isLabel', () {
    test(
      'should return true when code starts with the label delimeter "("',
      () async {
        //arrange
        //act
        final isLabel = labelParser.isLabel('(I_AM_A_LABEL)');
        //assert
        expect(isLabel, true);
      },
    );
    test(
      'should return false when code does not start with the label delimeter "("',
      () async {
        //arrange
        //act
        final isLabel = labelParser.isLabel('I_AM_A_LABEL)');
        //assert
        expect(isLabel, false);
      },
    );
  });

  group('isValidLabel', () {
    test(
      'should return true when code starts and ends with parentheses, '
      'and the first character of the label name is an alphabetical character',
      () async {
        //arrange
        //act
        final isValidLabel = labelParser.isValidLabel('(I_AM_A_LABEL)');
        //assert
        expect(isValidLabel, true);
      },
    );
    test(
      'should return false when code does not starts with parentheses, ',
      () async {
        //arrange
        final noOpeningParentheses = 'FORGOT_OPENING_BRACKET)';
        //act
        final isValidLabel = labelParser.isValidLabel(noOpeningParentheses);
        //assert
        expect(isValidLabel, false);
      },
    );

    test(
      'should return false when code does not end with parentheses, ',
      () async {
        //arrange
        final noEndingParentheses = '(FORGOT_END_BRACKET';
        //act
        final isValidLabel = labelParser.isValidLabel(noEndingParentheses);
        //assert
        expect(isValidLabel, false);
      },
    );

    test(
      'should return false when label name '
      'does not start with an alphabetical character, ',
      () async {
        //arrange
        final noEndingParentheses = '(_BAD_LABEL_NAME_SYNTAX)';
        //act
        final isValidLabel = labelParser.isValidLabel(noEndingParentheses);
        //assert
        expect(isValidLabel, false);
      },
    );
  });

  group('parseLabel', () {
    test(
      'should return an InvalidLabelFailure when code contains invalid label',
      () async {
        //arrange
        final invalidLabelCode = '(1_AM_A_LABEL)';
        //act
        final failureOption = labelParser.parseLabel(invalidLabelCode, 0);
        //assert
        expect(failureOption, some(InvalidLabelFailure()));
      },
    );
    test(
      'should return none when code contains valid label',
      () async {
        //arrange
        final validLabelCode = '(VALID_LABEL_KEY)';
        final validLabelKey = 'VALID_LABEL_KEY';
        when(symbols.put(validLabelKey, '123')).thenAnswer((_) => none());
        //act
        final failureOption = labelParser.parseLabel(validLabelCode, 123);
        //assert
        expect(failureOption, none());
      },
    );

    test(
      'should call symbols put with correct args when code contains valid label',
      () async {
        //arrange
        final validLabelCode = '(VALID_LABEL_KEY)';
        final validLabelKey = 'VALID_LABEL_KEY';
        final validCodelineNumber = 123;
        final labelValString = '123';
        when(symbols.put(validLabelKey, labelValString))
            .thenAnswer((_) => none());
        //act
        labelParser.parseLabel(validLabelCode, validCodelineNumber);
        //assert
        verify(symbols.put(validLabelKey, labelValString));
      },
    );
  });
}
