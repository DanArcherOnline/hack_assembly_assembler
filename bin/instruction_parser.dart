import 'typedefs.dart';

abstract class InstructionParser {
  FailureOrInstruction parse(String code);
  bool isValid(String code);
}
