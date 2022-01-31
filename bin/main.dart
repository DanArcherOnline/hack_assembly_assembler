import 'dart:io';

import 'package:args/args.dart';

import 'assembly_parser.dart';
import 'line_processer.dart';
import 'machine_code_translator.dart';
import 'machine_code_writer.dart';
import 'service_locator.dart';

const pathArgName = 'path';
const pathArgAbbr = 'p';

void main(List<String> arguments) {
  configureDependencies();
  final path = getFileName(arguments);
  final fileIn = File(path);
  final fileOut = File(fileIn.path.replaceFirst('.asm', '.hack'));
  print('🤮 fileOut.path: ${fileOut.path}');
  final lineProcesser = sl<LineProcesser>();
  final assemblyParser = sl<AssemblyParser>();
  final machineCodeTranslator = sl<MachineCodeTranslator>();
  final writer = MachineCodeWriter(file: fileOut);
  var lineNumber = 1;
  lineProcesser.processLines(
    file: fileIn,
    lineOperation: (line) {
      print('Line No. $lineNumber');
      final failureOrAssemblyInstruction = assemblyParser.parse(line);
      failureOrAssemblyInstruction.fold(
        (failure) => failure.map(
          notInstruction: (f) {
            print('was not an instruction');
          },
          valueTooLarge: (f) {
            print('the value was too large');
          },
          invalidAInstructionValue: (f) {
            print('A instructions value is incorrect');
          },
          invalidCInstructionDestination: (f) {
            print('C instructions destination is incorrect');
          },
          invalidCInstructionComputation: (f) {
            print('C instructions computation is incorrect');
          },
          invalidCInstructionJump: (f) {
            print('C instructions jump is incorrect');
          },
        ),
        (instruction) {
          final failureOrMachineCodeInstruction =
              machineCodeTranslator.translate(instruction);
          failureOrMachineCodeInstruction.fold(
            (failure) => throw Exception('Failed to translate to Machine Code'),
            (machineCodeInstruction) {
              writer.write(machineCodeInstruction);
            },
          );
        },
      );
      lineNumber++;
    },
  );

  // lineProcesser.processLines(
  //     file: file,
  //     lineOperation: (line) {
  //       final failureOrInstruction = assemblyParser.parse(line);
  //       final machineCodeTranslator = sl<MachineCodeTranslator>();
  //       failureOrInstruction.fold(
  //         (failure) => failure.map(
  //           notInstruction: (f) {
  //             print('was not an instruction');
  //           },
  //           valueTooLarge: (f) {
  //             print('the value was too large');
  //           },
  //           invalidAInstructionValue: (f) {
  //             print('A instructions value is incorrect');
  //           },
  //           invalidCInstructionDestination: (f) {
  //             print('C instructions destination is incorrect');
  //           },
  //           invalidCInstructionComputation: (f) {
  //             print('C instructions computation is incorrect');
  //           },
  //           invalidCInstructionJump: (f) {
  //             print('C instructions jump is incorrect');
  //           },
  //         ),
  //         (instruction) {
  //           instruction.map(
  //             aInstruction: (a) {
  //               print('---A instruction---');
  //               print('Value: ${a.value}');
  //             },
  //             cInstruction: (c) {
  //               print('---C Instruction---');
  //               print('Destination: ${c.destination}');
  //               print('Computation: ${c.computation}');
  //               print('Jump: ${c.jump}');
  //             },
  //           );
  //         },
  //       );
  //       failureOrInstruction.map((assemblyInstruction) {
  //         final failureOrBinary =
  //             machineCodeTranslator.translate(assemblyInstruction);
  //         final binary = failureOrBinary.getOrElse(
  //           () => throw Exception('could not translate instruction to binary'),
  //         );
  //         print(binary);
  //       });
  //     });
}

String getFileName(List<String> arguments) {
  final argsParser = ArgParser();
  argsParser.addOption(
    pathArgName,
    abbr: pathArgAbbr,
  );
  final args = argsParser.parse(arguments);
  return args[pathArgName];
}
