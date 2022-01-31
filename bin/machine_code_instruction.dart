import 'package:freezed_annotation/freezed_annotation.dart';

part 'machine_code_instruction.freezed.dart';

@freezed
class MachineCodeInstruction with _$MachineCodeInstruction {
  static const bitLength = 16;
  const factory MachineCodeInstruction({required String value}) =
      _MachineCodeInstruction;
}
