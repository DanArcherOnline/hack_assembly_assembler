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

  Option<Failure> parseLabel(String code, int lineNumber) {
    if (!isValidLabel(code)) {
      return some(InvalidLabelFailure());
    }
    final labelKey = _extractKey(code);
    _symbols.put(labelKey, lineNumber.toString());
    return none();
  }

  bool isValidLabel(code) => RegExp(r'^\([a-zA-Z][^ ]*\)$').hasMatch(code);

  String _extractKey(String code) => code.substring(1, code.length - 1);

  //TODO remove below debug getter
  Map<String, String> get debugSymbols => _symbols.debugSymbols;
}
