import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../core/failure.dart';
import '../core/typedefs.dart';
import 'assembly_instruction.dart';
import 'instruction_parser.dart';
import 'symbols.dart';

@injectable
class AInstructionParser implements InstructionParser {
  static const aInstructionSymbol = '@';
  static const maxVal = 32767; //2^15-1

  final Symbols _symbols;

  AInstructionParser({required Symbols symbols}) : _symbols = symbols;

  @override
  bool isValid(String code) => code.startsWith(aInstructionSymbol);

  bool _isValue(String code) => RegExp(r'^[0-9]+$').hasMatch(code);

  @override
  FailureOrInstruction parse({
    required String minifiedCode,
    required String rawCode,
    required int lineNumber,
  }) {
    final extractedCode = _extract(minifiedCode);
    if (extractedCode.isEmpty) {
      return left(InvalidAInstructionValueFailure(
        type: InvalidAInstructionValueType.noValue,
        lineNumber: lineNumber,
        line: rawCode,
      ));
    }
    if (_isValue(extractedCode)) {
      return _parseValue(
        valString: extractedCode,
        lineNumber: lineNumber,
        rawCode: rawCode,
      );
    }
    return _parseSymbol(
      symbolKey: extractedCode,
      lineNumber: lineNumber,
      rawCode: rawCode,
    );
  }

  Either<Failure, AInstruction> _parseValue({
    required String valString,
    required int lineNumber,
    required String rawCode,
  }) {
    late int val;
    try {
      val = int.parse(valString);
    } catch (e) {
      return left(InvalidAInstructionValueFailure(
        type: InvalidAInstructionValueType.notANumber,
        lineNumber: lineNumber,
        line: rawCode,
      ));
    }
    if (_isOverMaxValue(val)) {
      return left(InvalidAInstructionValueFailure(
        type: InvalidAInstructionValueType.valueTooLarge,
        lineNumber: lineNumber,
        line: rawCode,
      ));
    }
    return right(AInstruction(value: valString));
  }

  Either<Failure, AInstruction> _parseSymbol({
    required String symbolKey,
    required int lineNumber,
    required String rawCode,
  }) {
    if (_symbols.isValidKey(symbolKey)) {
      return _symbols.get(symbolKey).map((value) => AInstruction(value: value));
    }
    return left(InvalidAInstructionValueFailure(
      type: InvalidAInstructionValueType.invalidSymbolSyntax,
      lineNumber: lineNumber,
      line: rawCode,
    ));
  }

  String _extract(String code) => code.replaceFirst(aInstructionSymbol, '');

  bool _isOverMaxValue(int val) => val > maxVal;
}
