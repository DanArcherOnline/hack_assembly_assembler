import 'typedefs.dart';

abstract class InstructionParser {
  FailureOrInstruction parse({
    required String code,
    required int lineNumber,
  });
  bool isValid(String code);
}
