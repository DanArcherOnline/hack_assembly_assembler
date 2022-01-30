import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import './int_extension.dart';
import 'failure.dart';
import 'instruction.dart';
import 'machine_code_instruction.dart';
import 'typedefs.dart';

@lazySingleton
class MachineCodeTranslator {
  static const destinationTranslationTable = {
    'null': '000',
    'M': '001',
    'D': '010',
    'DM': '011',
    'A': '100',
    'AM': '101',
    'AD': '110',
    'ADM': '111',
  };
  static const computationTranslationTable0 = {
    '0': '101010',
    '1': '111111',
    '-1': '111010',
    'D': '001100',
    'A': '110000',
    '!D': '001101',
    '!A': '110001',
    '-D': '001111',
    '-A': '110011',
    'D+1': '011111',
    'A+1': '110111',
    'D-1': '001110',
    'A-1': '110010',
    'D+A': '000010',
    'D-A': '010011',
    'A-D': '000111',
    'D&A': '000000',
    'D|A': '010101',
  };
  static const computationTranslationTable1 = {
    'M': '110000',
    '!M': '110001',
    '-M': '110011',
    'M+1': '110111',
    'M-1': '110010',
    'D+M': '000010',
    'D-M': '010011',
    'M-D': '000111',
    'D&M': '000000',
    'D|M': '010101',
  };
  static const jumpTranslationTable = {
    'null': '000',
    'JGT': '001',
    'JEQ': '010',
    'JGE': '011',
    'JLT': '100',
    'JNE': '101',
    'JLE': '110',
    'JMP': '111',
  };
  FailureOrMachineCodeInstruction translate(AssemblyInstruction instruction) {
    final failureOrBinaryInstruction = instruction.map(
      aInstruction: _translateAInstruction,
      cInstruction: _translateCInstruction,
    );
    return failureOrBinaryInstruction.map(
      (binaryString) => MachineCodeInstruction(value: binaryString),
    );
  }

  Either<Failure, String> _translateAInstruction(AInstruction aInstruction) {
    const aInstructionTypeBinary = '0';
    final aInstructionValue = int.tryParse(aInstruction.value);
    if (aInstructionValue == null) {
      return left(InvalidAInstructionValueFailure());
    }
    final aInstructionValueBinary = aInstructionValue.toBinary();
    final fullAInstructionValueBinary = aInstructionValueBinary.padLeft(
        MachineCodeInstruction.bitLength - 1, '0');
    final aInstructionBinary =
        aInstructionTypeBinary + fullAInstructionValueBinary;
    return right(aInstructionBinary);
  }

  Either<Failure, String> _translateCInstruction(CInstruction cInstruction) {
    Failure? failure;
    const cInstructionTypeBinary = '111';

    final binaryInstruciton = StringBuffer();
    binaryInstruciton.write(cInstructionTypeBinary);

    final failureOrDestBinary =
        _translateDestinationToBinary(cInstruction.destination);
    failureOrDestBinary.fold(
      (f) => failure ??= f,
      (dest) => binaryInstruciton.write(dest),
    );

    final failureOrCompBinary =
        _translateComputationToBinary(cInstruction.computation);
    failureOrCompBinary.fold(
      (f) => failure ??= f,
      (comp) => binaryInstruciton.write(comp),
    );

    final failureOrJumpBinary = _translateJumpToBinary(cInstruction.jump);
    failureOrJumpBinary.fold(
      (f) => failure ??= f,
      (jump) => binaryInstruciton.write(jump),
    );

    if (failure != null) {
      return left(failure!);
    }

    return right(binaryInstruciton.toString());
  }

  Either<Failure, String?> _translateDestinationToBinary(String? destination) {
    if (destination == null) {
      final nullDestBinary = destinationTranslationTable['null'];
      return right(nullDestBinary);
    }
    final destBinary = destinationTranslationTable[destination];
    if (destBinary == null) {
      return left(InvalidCInstructionDestinationFailure());
    }
    return right(destBinary);
  }

  Either<Failure, String?> _translateComputationToBinary(String? computation) {
    const compTable0Binary = '0';
    const compTable1Binary = '1';
    final comp0 = computationTranslationTable0[computation];
    if (comp0 == null) {
      final comp1 = computationTranslationTable1[computation];
      if (comp1 == null) {
        return left(InvalidCInstructionComputationFailure());
      } else {
        final computationBinary = compTable1Binary + comp1;
        return right(computationBinary);
      }
    } else {
      final computationBinary = compTable0Binary + comp0;
      return right(computationBinary);
    }
  }

  Either<Failure, String?> _translateJumpToBinary(String? jump) {
    if (jump == null) {
      final nullJumpBinary = jumpTranslationTable['null'];
      return right(nullJumpBinary);
    }
    final jumpBinary = jumpTranslationTable[jump];
    if (jumpBinary == null) {
      return left(InvalidCInstructionJumpFailure());
    }
    return right(jumpBinary);
  }
}
