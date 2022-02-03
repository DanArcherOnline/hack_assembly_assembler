import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'assembly_instruction.dart';
import 'failure.dart';
import 'instruction_parser.dart';
import 'symbols.dart';
import 'typedefs.dart';

@injectable
class AInstructionParser implements InstructionParser {
  static const aInstructionSymbol = '@';
  //TODO change to correct max value
  static const maxVal = 1000000;

  final Symbols _symbols;

  AInstructionParser({required Symbols symbols}) : _symbols = symbols;

  @override
  bool isValid(String code) => code.startsWith(aInstructionSymbol);

  bool _isValue(String code) => RegExp(r'^[0-9]+$').hasMatch(code);

  @override
  FailureOrInstruction parse(String code) {
    final extractedCode = _extract(code);
    if (extractedCode.isEmpty) {
      return left(InvalidAInstructionValueFailure());
    }
    if (_isValue(extractedCode)) {
      return _parseValue(extractedCode);
    }
    return _parseSymbol(extractedCode);
  }

  Either<Failure, AInstruction> _parseValue(String valString) {
    late int val;
    try {
      val = int.parse(valString);
    } catch (e) {
      return left(InvalidAInstructionValueFailure());
    }
    if (_isOverMaxValue(val)) {
      return left(InvalidAInstructionValueFailure());
    }
    return right(AInstruction(value: valString));
  }

  Either<Failure, AInstruction> _parseSymbol(String symbolKey) {
    if (_symbols.isValidKey(symbolKey)) {
      return _symbols.get(symbolKey).map((value) => AInstruction(value: value));
    }
    return left(InvalidAInstructionValueFailure());
  }

  String _extract(String code) => code.replaceFirst(aInstructionSymbol, '');

  bool _isOverMaxValue(int val) => val > maxVal;
}
