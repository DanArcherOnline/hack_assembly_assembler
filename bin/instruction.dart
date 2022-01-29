import 'package:freezed_annotation/freezed_annotation.dart';

part 'instruction.freezed.dart';

@freezed
class Instruction with _$Instruction {
  const factory Instruction.aInstruction({required String value}) =
      AInstruction;
  const factory Instruction.cInstruction({
    String? destination,
    String? computation,
    String? jump,
  }) = CInstruction;
}
