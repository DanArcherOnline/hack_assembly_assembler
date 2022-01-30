import 'package:freezed_annotation/freezed_annotation.dart';

part 'instruction.freezed.dart';

@freezed
class AssemblyInstruction with _$AssemblyInstruction {
  const factory AssemblyInstruction.aInstruction({required String value}) =
      AInstruction;
  const factory AssemblyInstruction.cInstruction({
    String? destination,
    String? computation,
    String? jump,
  }) = CInstruction;
}
