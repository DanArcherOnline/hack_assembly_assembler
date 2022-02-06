import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../core/failure.dart';
import '../core/int_extension.dart';
import '../core/typedefs.dart';
import '../parsing/a_instruction_parser.dart';
import '../parsing/assembly_instruction.dart';
import 'machine_code_instruction.dart';

@lazySingleton
class MachineCodeTranslator {
  static const destinationTranslationTable = {
    'null': '000',
    'M': '001',
    'D': '010',
    'DM': '011',
    'MD': '011',
    'A': '100',
    'AM': '101',
    'MA': '101',
    'AD': '110',
    'DA': '110',
    'ADM': '111',
    'AMD': '111',
    'DMA': '111',
    'DAM': '111',
    'MAD': '111',
    'MDA': '111',
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
    'A+D': '000010',
    'D-A': '010011',
    'A-D': '000111',
    'D&A': '000000',
    'A&D': '000000',
    'D|A': '010101',
    'A|D': '010101',
  };
  static const computationTranslationTable1 = {
    'M': '110000',
    '!M': '110001',
    '-M': '110011',
    'M+1': '110111',
    'M-1': '110010',
    'D+M': '000010',
    'M+D': '000010',
    'D-M': '010011',
    'M-D': '000111',
    'D&M': '000000',
    'M&D': '000000',
    'D|M': '010101',
    'M|D': '010101',
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
  FailureOrMachineCodeInstruction translate({
    required AssemblyInstruction instruction,
    required int lineNumber,
    required String line,
  }) {
    final failureOrBinaryInstruction = instruction.map(
      aInstruction: (aInstruction) => _translateAInstruction(
          aInstruction: aInstruction, lineNumber: lineNumber, rawCode: line),
      cInstruction: (cInstruction) => _translateCInstruction(
        cInstruction: cInstruction,
        lineNumber: lineNumber,
        rawCode: line,
      ),
    );
    return failureOrBinaryInstruction.map(
      (binaryString) => MachineCodeInstruction(value: binaryString),
    );
  }

  Either<Failure, String> _translateAInstruction({
    required AInstruction aInstruction,
    required int lineNumber,
    required String rawCode,
  }) {
    const aInstructionTypeBinary = '0';
    final aInstructionValue = int.tryParse(aInstruction.value);
    if (aInstructionValue == null) {
      return left(InvalidAInstructionValueFailure(
        type: InvalidAInstructionValueType.notANumber,
        lineNumber: lineNumber,
        line: rawCode,
      ));
    } else if (aInstructionValue > AInstructionParser.maxVal) {
      return left(InvalidAInstructionValueFailure(
        type: InvalidAInstructionValueType.valueTooLarge,
        lineNumber: lineNumber,
        line: rawCode,
      ));
    }
    final aInstructionValueBinary = aInstructionValue.toBinary();
    final fullAInstructionValueBinary = aInstructionValueBinary.padLeft(
        MachineCodeInstruction.bitLength - 1, '0');
    final aInstructionBinary =
        aInstructionTypeBinary + fullAInstructionValueBinary;
    return right(aInstructionBinary);
  }

  Either<Failure, String> _translateCInstruction({
    required CInstruction cInstruction,
    required int lineNumber,
    required String rawCode,
  }) {
    Failure? failure;
    const cInstructionTypeBinary = '111';
    final binaryInstruciton = StringBuffer();
    binaryInstruciton.write(cInstructionTypeBinary);
    failure ??= writeComputationBinaryToStringBuffer(
      cInstruction: cInstruction,
      binaryInstruciton: binaryInstruciton,
      lineNumber: lineNumber,
      rawCode: rawCode,
    );
    failure ??= writeDestinationBinaryToStringBuffer(
      cInstruction: cInstruction,
      binaryInstruciton: binaryInstruciton,
      lineNumber: lineNumber,
      rawCode: rawCode,
    );
    failure ??= writeJumpBinaryToStringBuffer(
      cInstruction: cInstruction,
      binaryInstruciton: binaryInstruciton,
      lineNumber: lineNumber,
      rawCode: rawCode,
    );
    if (failure != null) {
      return left(failure);
    }
    return right(binaryInstruciton.toString());
  }

  Failure? writeJumpBinaryToStringBuffer({
    required CInstruction cInstruction,
    required StringBuffer binaryInstruciton,
    required int lineNumber,
    required String rawCode,
  }) {
    Failure? failure;
    final failureOrJumpBinary = _translateJumpToBinary(
      jump: cInstruction.jump,
      lineNumber: lineNumber,
      rawCode: rawCode,
    );
    failureOrJumpBinary.fold(
      (f) => failure ??= f,
      (jump) => binaryInstruciton.write(jump),
    );
    return failure;
  }

  Failure? writeComputationBinaryToStringBuffer(
      {required CInstruction cInstruction,
      required StringBuffer binaryInstruciton,
      required int lineNumber,
      required String rawCode,
      required}) {
    Failure? failure;
    final failureOrCompBinary = _translateComputationToBinary(
      computation: cInstruction.computation,
      lineNumber: lineNumber,
      rawCode: rawCode,
    );
    failureOrCompBinary.fold(
      (f) => failure ??= f,
      (comp) => binaryInstruciton.write(comp),
    );
    return failure;
  }

  Failure? writeDestinationBinaryToStringBuffer({
    required CInstruction cInstruction,
    required StringBuffer binaryInstruciton,
    required int lineNumber,
    required String rawCode,
  }) {
    Failure? failure;
    final failureOrDestBinary = _translateDestinationToBinary(
      destination: cInstruction.destination,
      lineNumber: lineNumber,
      rawCode: rawCode,
    );
    failureOrDestBinary.fold(
      (f) => failure ??= f,
      (dest) => binaryInstruciton.write(dest),
    );
    return failure;
  }

  Either<Failure, String?> _translateDestinationToBinary({
    required String? destination,
    required int lineNumber,
    required String rawCode,
  }) {
    if (destination == null) {
      final nullDestBinary = destinationTranslationTable['null'];
      return right(nullDestBinary);
    }
    final destBinary = destinationTranslationTable[destination];
    if (destBinary == null) {
      return left(InvalidCInstructionDestinationFailure(
        type: InvalidCInstructionDestinationType.notFound,
        lineNumber: lineNumber,
        line: rawCode,
      ));
    }
    return right(destBinary);
  }

  Either<Failure, String?> _translateComputationToBinary({
    required String? computation,
    required int lineNumber,
    required String rawCode,
  }) {
    const compTable0BinaryPrefix = '0';
    const compTable1BinaryPrefix = '1';
    final compTranslationFromTable0 = computationTranslationTable0[computation];
    if (compTranslationFromTable0 != null) {
      return right(compTable0BinaryPrefix + compTranslationFromTable0);
    }
    final compTranslationFromTable1 = computationTranslationTable1[computation];
    if (compTranslationFromTable1 != null) {
      return right(compTable1BinaryPrefix + compTranslationFromTable1);
    }
    return left(InvalidCInstructionComputationFailure(
      type: InvalidCInstructionComputationType.notFound,
      lineNumber: lineNumber,
      line: rawCode,
    ));

    //TODO decide to delete or not
    // if (compTranslationFromTable0 == null) {
    //   final compTranslationFromTable1 =
    //       computationTranslationTable1[computation];
    //   if (compTranslationFromTable1 == null) {
    //     return left(InvalidCInstructionComputationFailure());
    //   } else {
    //     final computationBinary =
    //         compTranslationFromTable1 + compTable1BinaryPrefix;
    //     return right(computationBinary);
    //   }
    // } else {
    //   final computationBinary =
    //       compTranslationFromTable0 + compTable0BinaryPrefix;
    //   return right(computationBinary);
    // }
  }

  Either<Failure, String?> _translateJumpToBinary({
    required String? jump,
    required int lineNumber,
    required String rawCode,
  }) {
    if (jump == null) {
      final nullJumpBinary = jumpTranslationTable['null'];
      return right(nullJumpBinary);
    }
    final jumpBinary = jumpTranslationTable[jump];
    if (jumpBinary == null) {
      return left(InvalidCInstructionJumpFailure(
        type: InvalidCInstructionJumpType.notFound,
        lineNumber: lineNumber,
        line: rawCode,
      ));
    }
    return right(jumpBinary);
  }
}
