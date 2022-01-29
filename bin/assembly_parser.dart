import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'a_instruction_parser.dart';
import 'c_instruction_parser.dart';
import 'failure.dart';
import 'typedefs.dart';

@lazySingleton
class AssemblyParser {
  final AInstructionParser aInstructionParser;
  final CInstructionParser cInstructionParser;

  AssemblyParser(this.aInstructionParser, this.cInstructionParser);

  FailureOrInstruction parse(String line) {
    final code = line.replaceAll(' ', '');

    if (aInstructionParser.isValid(code)) {
      return aInstructionParser.parse(code);
    }
    if (cInstructionParser.isValid(code)) {
      return cInstructionParser.parse(code);
    }
    return left(NotInstructionFailure());
  }
}
