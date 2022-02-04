import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../core/failure.dart';
import '../core/typedefs.dart';
import 'a_instruction_parser.dart';
import 'c_instruction_parser.dart';

@lazySingleton
class AssemblyParser {
  //TODO make dependecies private
  final AInstructionParser aInstructionParser;
  final CInstructionParser cInstructionParser;

  AssemblyParser(
    this.aInstructionParser,
    this.cInstructionParser,
  );

  FailureOrInstruction parse({
    required String line,
    required int lineNumber,
  }) {
    final code = minifyCode(line);
    if (aInstructionParser.isValid(code)) {
      return aInstructionParser.parse(code: code, lineNumber: lineNumber);
    }
    if (cInstructionParser.isValid(code)) {
      return cInstructionParser.parse(code: code, lineNumber: lineNumber);
    }
    return left(NotInstructionFailure());
  }

  String minifyCode(String line) {
    final commentStartIndex = line.indexOf('//');
    final commentlessCode =
        commentStartIndex != -1 ? line.substring(0, commentStartIndex) : line;
    return commentlessCode.replaceAll(' ', '');
  }
}
