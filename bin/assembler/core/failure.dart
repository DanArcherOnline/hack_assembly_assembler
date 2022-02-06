import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.notInstruction({
    required NotInstructionType type,
    int? lineNumber,
    String? line,
  }) = NotInstructionFailure;
  const factory Failure.invalidAInstructionValue({
    required InvalidAInstructionValueType type,
    int? lineNumber,
    String? line,
  }) = InvalidAInstructionValueFailure;
  const factory Failure.invalidCInstructionDestination({
    required InvalidCInstructionDestinationType type,
    int? lineNumber,
    String? line,
  }) = InvalidCInstructionDestinationFailure;
  const factory Failure.invalidCInstructionComputation({
    required InvalidCInstructionComputationType type,
    int? lineNumber,
    String? line,
  }) = InvalidCInstructionComputationFailure;
  const factory Failure.invalidCInstructionJump({
    required InvalidCInstructionJumpType type,
    int? lineNumber,
    String? line,
  }) = InvalidCInstructionJumpFailure;
  const factory Failure.InvalidFilePath({
    required InvalidFilePathType type,
    int? lineNumber,
    String? line,
  }) = InvalidFilePathFailure;
  const factory Failure.invalidLabel({
    required InvalidLabelType type,
    int? lineNumber,
    String? line,
  }) = InvalidLabelFailure;
}

enum NotInstructionType {
  validNonCode,
  invalidSyntax,
}
enum InvalidAInstructionValueType {
  valueTooLarge,
  noValue,
  notANumber,
  invalidSymbolSyntax,
}
enum InvalidCInstructionDestinationType {
  invalidSyntax,
  notFound,
}
enum InvalidCInstructionComputationType {
  invalidSyntax,
  notFound,
}
enum InvalidCInstructionJumpType {
  invalidSyntax,
  notFound,
}

enum InvalidFilePathType {
  noFilePath,
  invalidFileExtension,
}
//TODO delete if not needed
enum SymbolDoesNotExistType {
  a,
}
enum InvalidLabelType {
  unimplementedLabel,
  invalidSyntax,
  alreadyExists,
}
