import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'failure.dart';
import 'instruction.dart';
import 'instruction_parser.dart';
import 'typedefs.dart';

@injectable
class AInstructionParser implements InstructionParser {
  static const aInstructionSymbol = '@';
  //TODO change to correct max value
  static const maxVal = 1000000;

  @override
  bool isValid(String code) => code.startsWith(aInstructionSymbol);

  @override
  FailureOrInstruction parse(String code) {
    late int val;
    final valString = code.substring(1);
    try {
      val = int.parse(valString);
    } catch (e) {
      return left(InvalidAInstructionValueFailure());
    }
    if (_isOverMaxValue(val)) {
      return left(ValueTooLargeFailure());
    }
    return right(AInstruction(value: valString));
  }

  bool _isOverMaxValue(int val) => val > maxVal;
}
