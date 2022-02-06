import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../core/failure.dart';
import 'symbols.dart';

@injectable
class LabelParser {
  static const labelDelimeter = '(';
  final Symbols _symbols;

  LabelParser({required Symbols symbols}) : _symbols = symbols;

  bool isLabel(String code) => code.startsWith(labelDelimeter);

  Option<Failure> parseLabel({required String line, required int lineNumber}) {
    if (!isValidLabel(line)) {
      return some(InvalidLabelFailure(
        type: InvalidLabelType.invalidSyntax,
        lineNumber: lineNumber,
        line: line,
      ));
    }
    final labelKey = _extractKey(line);
    final failureOption = _symbols.put(labelKey, lineNumber.toString());
    final invalidLabelFailureOption = failureOption.map(
      (failure) => failure.maybeMap(
        invalidLabel: (invalidLabel) => InvalidLabelFailure(
          type: invalidLabel.type,
          lineNumber: lineNumber,
          line: line,
        ),
        orElse: () => throw Exception('An unexpected error has occured'),
      ),
    );
    return invalidLabelFailureOption;
  }

  bool isValidLabel(code) => RegExp(r'^\([a-zA-Z][^ ]*\)$').hasMatch(code);

  String _extractKey(String code) => code.substring(1, code.length - 1);
}
