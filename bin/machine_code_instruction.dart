class MachineCodeInstruction {
  static const bitLength = 16;
  final String value;

  MachineCodeInstruction({required this.value});

  @override
  String toString() => 'MachineCodeInstruction(value: $value)';
}
