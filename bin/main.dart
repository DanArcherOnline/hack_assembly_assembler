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
  configureDependencies(Env.dev);
  final path = getFileName(arguments);
  final fileIn = File(path);
  final lineProcesser = sl<LineProcesser>();
  final assemblyParser = sl<AssemblyParser>();
  final machineCodeTranslator = sl<MachineCodeTranslator>();
  //TODO catch writer instantiation errors and deal with them accordingly
  final writer = sl.get<MachineCodeWriter>(param1: fileIn.path);
  var lineNumber = 1;
  lineProcesser.processLines(
    file: fileIn,
    lineOperation: (line) {
      print('Line No. $lineNumber');
      final failureOrAssemblyInstruction = assemblyParser.parse(line);
      failureOrAssemblyInstruction.fold(
        (failure) => failure.maybeMap(
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
          orElse: () {
            print('An unexpected error has occured. Sorry about that...');
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
}

ArgResults getArgs(List<String> arguments) {
  final argsParser = ArgParser();
  argsParser.addOption(
    pathArgName,
    abbr: pathArgAbbr,
  );
  final args = argsParser.parse(arguments);
  return args;
}

String getFileName(List<String> arguments) => getArgs(arguments)[pathArgName];
String getEnvironment(List<String> arguments) =>
    getArgs(arguments)[pathArgName];
