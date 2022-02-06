import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../core/failure.dart';
import '../core/typedefs.dart';
import 'assembly_instruction.dart';
import 'instruction_parser.dart';

@injectable
class CInstructionParser implements InstructionParser {
  static const cInstructionRulesRegex =
      r'^([AMD0-9]*[;=]{1})([A-Z]{3}|[ADM0-9-+&|!]*)$';
  static const List<String> validDestinations = [
    'null',
    'M',
    'D',
    'DM',
    'MD',
    'A',
    'AM',
    'MA',
    'AD',
    'DA',
    'ADM',
    'AMD',
    'DAM',
    'DMA',
    'MAD',
    'MDA',
  ];

  static const List<String> validComputations = [
    '0',
    '1',
    '-1',
    'D',
    'A',
    '!D',
    '!A',
    '-D',
    '-A',
    'D+1',
    'A+1',
    'D-1',
    'A-1',
    'D+A',
    'A+D',
    'D-A',
    'A-D',
    'D&A',
    'A&D',
    'D|A',
    'A|D',
    'M',
    '!M',
    '-M',
    'M+1',
    'M-1',
    'D+M',
    'M+D',
    'D-M',
    'M-D',
    'D&M',
    'M&D',
    'D|M',
    'M|D',
  ];

  static const List<String> validJumps = [
    'null',
    'JGT',
    'JEQ',
    'JGE',
    'JLT',
    'JNE',
    'JLE',
    'JMP',
  ];

  @override
  FailureOrInstruction parse({
    required String minifiedCode,
    required String rawCode,
    required int lineNumber,
  }) {
    Failure? failure;
    String? destination;
    String? computation;
    String? jump;

    final failureOrDest = _parseDestination(
      code: minifiedCode,
      lineNumber: lineNumber,
      rawCode: rawCode,
    );
    failureOrDest.fold(
      (f) => failure ??= f,
      (dest) => destination = dest,
    );

    final failureOrComp = _parseComputation(
      code: minifiedCode,
      lineNumber: lineNumber,
      rawCode: rawCode,
    );
    failureOrComp.fold(
      (f) => failure ??= f,
      (comp) => computation = comp,
    );

    final failureOrJump = _parseJump(
      code: minifiedCode,
      lineNumber: lineNumber,
      rawCode: rawCode,
    );
    failureOrJump.fold(
      (f) => failure ??= f,
      (jmp) => jump = jmp,
    );

    if (failure != null) {
      return left(failure!);
    }

    var instruction = CInstruction(
      destination: destination,
      computation: computation,
      jump: jump,
    );
    return right(instruction);
  }

  Either<Failure, String?> _parseDestination({
    required String code,
    required int lineNumber,
    required String rawCode,
  }) {
    if (_hasDestination(code)) {
      final intendedDest = _extractDestinationFromCode(code);
      if (_isValidDestination(intendedDest)) {
        return right(intendedDest);
      } else {
        return left(InvalidCInstructionDestinationFailure(
          type: InvalidCInstructionDestinationType.invalidSyntax,
          lineNumber: lineNumber,
          line: rawCode,
        ));
      }
    }
    return right(null);
  }

  Either<Failure, String?> _parseComputation({
    required String code,
    required int lineNumber,
    required String rawCode,
  }) {
    var intendedComp = _extractComputation(code);
    if (intendedComp != null && _isValidComputation(intendedComp)) {
      return right(intendedComp);
    }
    if (_isValidComputation(code)) {
      return right(code);
    }
    return left(InvalidCInstructionComputationFailure(
      type: InvalidCInstructionComputationType.invalidSyntax,
      lineNumber: lineNumber,
      line: rawCode,
    ));
  }

  String? _extractComputation(String code) {
    final matches = RegExp(r'^.+=(.+)|(.+);.+$').firstMatch(code);
    final intendedAssignComp = matches?.group(1);
    if (intendedAssignComp != null) {
      return intendedAssignComp;
    }
    final intendedJumpComp = matches?.group(2);
    return intendedJumpComp;
  }

  Either<Failure, String?> _parseJump({
    required String code,
    required int lineNumber,
    required String rawCode,
  }) {
    final startIndex = code.indexOf(';');
    if (startIndex == -1) {
      return right(null);
    }
    final rawJump = code.substring(startIndex + 1);
    final intendedJump = rawJump.trim();
    if (_isValidJump(intendedJump)) {
      return right(intendedJump);
    }
    return left(InvalidCInstructionJumpFailure(
      type: InvalidCInstructionJumpType.invalidSyntax,
      lineNumber: lineNumber,
      line: rawCode,
    ));
  }

  bool _isValidJump(String intendedJump) => validJumps.contains(intendedJump);

  String _extractDestinationFromCode(String code) =>
      code.substring(0, code.indexOf(RegExp('[=]')));

  bool _isValidDestination(String intendedDest) =>
      validDestinations.contains(intendedDest);

  bool _hasDestination(String code) => code.contains('=');

  @override
  bool isValid(String code) => RegExp(cInstructionRulesRegex).hasMatch(code);

  bool _isValidComputation(String intendedComp) =>
      validComputations.contains(intendedComp);
}
