import 'package:injectable/injectable.dart';

import '../parsing/a_instruction_parser.dart';
import '../parsing/c_instruction_parser.dart';
import 'failure.dart';

@injectable
class ErrorParser {
  String? parse({
    required Failure failure,
  }) {
    if (failure.line == null || failure.lineNumber == null) {
      throw Exception(
        'Failure has not been mapped to a new Failure with '
        'the corresponding line of code and line number.\n'
        'Failure causing the error is:\n'
        '$failure',
      );
    }
    final message = failure.map<String?>(
      notInstruction: (notInstruction) =>
          getNotInstructionMessage(notInstruction),
      invalidAInstructionValue: (invalidAInstructionValue) =>
          getInvalidAInstructionValueMessage(invalidAInstructionValue),
      invalidCInstructionDestination: (invalidCInstructionDestination) =>
          getInvalidCInstructionDestinationMessage(
              invalidCInstructionDestination),
      invalidCInstructionComputation: (invalidCInstructionComputation) =>
          getInvalidCInstructionComputationMessage(
              invalidCInstructionComputation),
      invalidCInstructionJump: (invalidCInstructionJump) =>
          getInvalidCInstructionJumpMessage(invalidCInstructionJump),
      InvalidFilePath: (InvalidFilePath) =>
          getInvalidFilePathMessage(InvalidFilePath),
      invalidLabel: (invalidLabel) => getInvalidLabelMessage(invalidLabel),
    );
    return message;
  }

  String getInvalidLabelMessage(InvalidLabelFailure invalidLabel) {
    final s = StringBuffer();
    s.writeln('Line ${invalidLabel.lineNumber}: Invalid Label.');
    switch (invalidLabel.type) {
      case InvalidLabelType.unimplementedLabel:
        s.writeln('The label was defined but never given any implementation.');
        break;
      case InvalidLabelType.invalidSyntax:
        s.writeln('Labels must start with an alphabetical character.');
        break;
      case InvalidLabelType.alreadyExists:
        s.writeln(
            'There are duplicate labels. Change one of the labels names.');
        break;
    }
    s.writeln('------');
    s.writeln(invalidLabel.line);
    return s.toString();
  }

  String getInvalidFilePathMessage(
      InvalidFilePathFailure invalidFilePathFailure) {
    final s = StringBuffer();
    switch (invalidFilePathFailure.type) {
      case InvalidFilePathType.noFilePath:
        s.writeln('No file path was given. '
            'Run the assmbler with the command '
            '"dart run <file path to main> -p <file path to .asm file>"');
        break;
      case InvalidFilePathType.invalidFileExtension:
        s.writeln('The file specified does not have the file extension ".asm"');
        break;
    }
    return s.toString();
  }

  String getInvalidCInstructionJumpMessage(
      InvalidCInstructionJumpFailure instructionJumpFailure) {
    final s = StringBuffer();
    s.writeln(
        'Line ${instructionJumpFailure.lineNumber}: Invalid C Instruction');
    switch (instructionJumpFailure.type) {
      case InvalidCInstructionJumpType.invalidSyntax:
      case InvalidCInstructionJumpType.notFound:
        s.writeln('The Jump command in the code below does not exist.');
        final jumps = CInstructionParser.validJumps
            .reduce((value, element) => value += ', $element');
        s.writeln('Choose a Jump command from the following: $jumps');
        break;
    }
    s.writeln('------');
    s.writeln(instructionJumpFailure.line);
    return s.toString();
  }

  String getInvalidCInstructionComputationMessage(
      InvalidCInstructionComputationFailure instructionComputationFailure) {
    final s = StringBuffer();
    s.writeln(
        'Line ${instructionComputationFailure.lineNumber}: Invalid C Instruction');
    switch (instructionComputationFailure.type) {
      case InvalidCInstructionComputationType.invalidSyntax:
      case InvalidCInstructionComputationType.notFound:
        s.writeln('The Computation command in the code below does not exist.');
        final comps = CInstructionParser.validComputations
            .reduce((value, element) => value += ', $element');
        s.writeln('Choose a Computation command from the following: $comps');
        break;
    }
    s.writeln('------');
    s.writeln(instructionComputationFailure.line);
    return s.toString();
  }

  String getInvalidCInstructionDestinationMessage(
      InvalidCInstructionDestinationFailure instructionDestinationFailure) {
    final s = StringBuffer();
    s.writeln(
        'Line ${instructionDestinationFailure.lineNumber}: Invalid C Instruction');
    switch (instructionDestinationFailure.type) {
      case InvalidCInstructionDestinationType.invalidSyntax:
      case InvalidCInstructionDestinationType.notFound:
        s.writeln('The Destination in the code below does not exist.');
        final dests = CInstructionParser.validDestinations
            .reduce((value, element) => value += ', $element');
        s.writeln('Choose a Computation command from the following: $dests');
        break;
    }
    s.writeln('------');
    s.writeln(instructionDestinationFailure.line);
    return s.toString();
  }

  String getInvalidAInstructionValueMessage(
      InvalidAInstructionValueFailure invalidAInstructionValue) {
    final s = StringBuffer();
    s.writeln(
        'Line ${invalidAInstructionValue.lineNumber}: Invalid A Instruction');
    switch (invalidAInstructionValue.type) {
      case InvalidAInstructionValueType.valueTooLarge:
        s.writeln('The value in the code below exceeds the maximum value '
            'of ${AInstructionParser.maxVal}');
        break;
      case InvalidAInstructionValueType.noValue:
        s.writeln('There was no value given after the "@" character.');
        break;
      case InvalidAInstructionValueType.notANumber:
        s.writeln('The value specified after the "@" character '
            'was expected to be a number but was not.');
        s.writeln('It is possible that the value given was too large '
            'for the system to handle.');
        break;
      case InvalidAInstructionValueType.invalidSymbolSyntax:
        s.writeln('Symbols must start with an alphabetical character.');
        break;
    }
    s.writeln('------');
    s.writeln(invalidAInstructionValue.line);
    return s.toString();
  }

  String? getNotInstructionMessage(NotInstructionFailure notInstruction) {
    final s = StringBuffer();
    s.writeln('Line ${notInstruction.lineNumber}: Invalid Syntax');
    switch (notInstruction.type) {
      case NotInstructionType.validNonCode:
        return null;
      case NotInstructionType.invalidSyntax:
        s.writeln(
            'The code below was not valid syntax for an A Instruction or C Instruction');
        break;
    }
    s.writeln('------');
    s.writeln(notInstruction.line);
    return s.toString();
  }
}
