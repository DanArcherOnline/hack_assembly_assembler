import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'failure.dart';
import 'instruction.dart';
import 'instruction_parser.dart';
import 'typedefs.dart';

@injectable
class CInstructionParser implements InstructionParser {
  static const cInstructionRulesRegex =
      r'^([AMD0-9]*[;=]{1})(JMP|JGT|JLT|JGE|JLE|JEQ|JNE|[ADM0-9-+]*)$';
  static const List<String> validDestinations = [
    'null',
    'M',
    'D',
    'DM',
    'A',
    'AM',
    'AD',
    'ADM',
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
    'D-A',
    'A-D',
    'D&A',
    'D|A',
    'M',
    '!M',
    '-M',
    'M+1',
    'M-1',
    'D+M',
    'D-M',
    'M-D',
    'D&M',
    'D|M',
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
  FailureOrInstruction parse(String code) {
    Failure? failure;
    String? destination;
    String? computation;
    String? jump;

    final failureOrDest = _parseDestination(code);
    failureOrDest.fold(
      (f) => failure ??= f,
      (dest) => destination = dest,
    );

    final failureOrComp = _parseComputation(code);
    failureOrComp.fold(
      (f) => failure ??= f,
      (comp) => computation = comp,
    );

    final failureOrJump = _parseJump(code);
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

  Either<Failure, String?> _parseDestination(String code) {
    if (_hasDestination(code)) {
      final intendedDest = _extractDestinationFromCode(code);
      if (_isValidDestination(intendedDest)) {
        return right(intendedDest);
      } else {
        return left(InvalidCInstructionDestinationFailure());
      }
    }
    return right(null);
  }

  Either<Failure, String?> _parseComputation(String code) {
    var intendedComp = _extractComputation(code);
    if (intendedComp != null && _isValidComputation(intendedComp)) {
      return right(intendedComp);
    }
    if (_isValidComputation(code)) {
      return right(code);
    }
    return left(InvalidCInstructionComputationFailure());
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

  Either<Failure, String?> _parseJump(String code) {
    final startIndex = code.indexOf(';');
    if (startIndex == -1) {
      return right(null);
    }
    final rawJump = code.substring(startIndex + 1);
    final intendedJump = rawJump.trim();
    if (_isValidJump(intendedJump)) {
      return right(intendedJump);
    }
    return left(InvalidCInstructionJumpFailure());
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
