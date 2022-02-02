import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.notInstruction() = NotInstructionFailure;
  const factory Failure.valueTooLarge() = ValueTooLargeFailure;
  const factory Failure.invalidAInstructionValue() =
      InvalidAInstructionValueFailure;
  const factory Failure.invalidCInstructionDestination() =
      InvalidCInstructionDestinationFailure;
  const factory Failure.invalidCInstructionComputation() =
      InvalidCInstructionComputationFailure;
  const factory Failure.invalidCInstructionJump() =
      InvalidCInstructionJumpFailure;
  const factory Failure.InvalidFilePath() = InvalidFilePathFailure;
  const factory Failure.symbolDoesNotExist() = SymbolDoesNotExistFailure;
}
