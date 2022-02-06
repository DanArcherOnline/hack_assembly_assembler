import '../core/typedefs.dart';

abstract class InstructionParser {
  FailureOrInstruction parse({
    required String minifiedCode,
    required String rawCode,
    required int lineNumber,
  });
  bool isValid(String code);
}
