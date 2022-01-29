// class AssemblyParser {
//   Instruction parse(String line) {
//     final code = line.trim();
//     if (_isNotAssemblyCode(code)) {
//       return NotInstruction();
//     }
//     if (_isAInstruction(code)) {
//       final value = code.substring(1);
//       //TODO handle too long value
//       return AInstruction(
//         value: value,
//       );
//     } else {
//       final destination = OldCInstruction.destinations.firstWhere(
//         (comp) {
//           return code.contains(comp);
//         },
//         orElse: () {
//           //TODO handle no comp
//           return 'null';
//         },
//       );

//       final computation = OldCInstruction.computations.firstWhere(
//         (comp) => code.contains(comp),
//         orElse: () {
//           //TODO handle no comp
//           return 'null';
//         },
//       );

//       final jump = OldCInstruction.jumps.firstWhere(
//         (comp) => code.contains(comp),
//         orElse: () {
//           //TODO handle no comp
//           return 'null';
//         },
//       );

//       return OldCInstruction(
//         destination: destination,
//         computation: computation,
//         jump: jump,
//       );
//     }
//   }

//   bool _isNotAssemblyCode(String code) => code.isEmpty || code.startsWith('//');

//   bool _isAInstruction(String code) => code.startsWith('@');
// }

// class SymbolNotFoundException implements Exception {}

// abstract class Instruction {}

// class AInstruction implements Instruction {
//   final String value;
//   AInstruction({required this.value});

//   @override
//   String toString() => 'AInstruction(value: $value)';
// }

// class OldCInstruction implements Instruction {
//   final String destination;
//   final String computation;
//   final String jump;

//   OldCInstruction({
//     required this.destination,
//     required this.computation,
//     required this.jump,
//   });

//   @override
//   String toString() =>
//       'CInstruction(destination: $destination, computation: $computation, jump: $jump)';

//   static const List<String> destinations = [
//     'null',
//     'M',
//     'D',
//     'DM',
//     'A',
//     'AM',
//     'AD',
//     'ADM',
//   ];

//   static const List<String> computations = [
//     '0',
//     '1',
//     '-1',
//     'D',
//     'A',
//     '!D',
//     '!A',
//     '-D',
//     '-A',
//     'D+1',
//     'A+1',
//     'D-1',
//     'A-1',
//     'D+A',
//     'D-A',
//     'A-D',
//     'D&A',
//     'D|A',
//     'M',
//     '!M',
//     '-M',
//     'M+1',
//     'M-1',
//     'D+M',
//     'D-M',
//     'M-D',
//     'D&M',
//     'D|M',
//   ];

//   static const List<String> jumps = [
//     'null',
//     'JGT',
//     'JEQ',
//     'JGE',
//     'JLT',
//     'JNE',
//     'JLE',
//     'JMP',
//   ];
// }

// class NotInstruction implements Instruction {}
