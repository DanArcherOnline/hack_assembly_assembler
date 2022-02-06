import 'package:args/args.dart';
import 'package:file/file.dart';

import 'Operations/label_parse_operation.dart';
import 'Operations/translate_operation.dart';
import 'core/environment.dart';
import 'core/error_parser.dart';
import 'core/service_locator.dart';
import 'io/line_processer.dart';
import 'io/machine_code_writer.dart';
import 'parsing/assembly_parser.dart';
import 'parsing/label_parser.dart';
import 'parsing/line_tracker.dart';
import 'translation/machine_code_translator.dart';

const pathArgName = 'path';
const pathArgAbbr = 'p';

void main(List<String> arguments) async {
  configureDependencies(Env.dev);
  final path = getFileName(arguments);
  final fileSystem = sl<FileSystem>();
  final fileIn = fileSystem.file(path);
  final labelParseOperation = sl<LabelParseOperation>();
  await labelParseOperation.run(fileIn);

  final lineTracker = sl<LineTracker>();
  final lineProcesser = sl<LineProcesser>();
  final assemblyParser = sl<AssemblyParser>();
  final translator = sl<MachineCodeTranslator>();
  final labelParser = sl<LabelParser>();
  final writer = sl.get<MachineCodeWriter>(param1: fileIn.path);
  final errorParser = sl<ErrorParser>();

  final translateOperation = TranslateOperation(
    assemblyParser,
    translator,
    writer,
    lineProcesser,
    lineTracker,
    labelParser,
    errorParser,
  );
  await translateOperation.run(fileIn);

  // final lineTracker = sl<LineTracker>();
  // final labelParser = sl<LabelParser>();
  // final lineProcesser = sl<LineProcesser>();
  // final assemblyParser = sl<AssemblyParser>();
  // final machineCodeTranslator = sl<MachineCodeTranslator>();
  // //TODO catch writer instantiation errors and deal with them accordingly
  // final writer = sl.get<MachineCodeWriter>(param1: fileIn.path);
  // var lineNumber = 1;
  // lineProcesser.processLines(
  //   file: fileIn,
  //   lineOperation: (line) {
  //     print('Line No. $lineNumber');
  //     final failureOrAssemblyInstruction = assemblyParser.parse(line);
  //     failureOrAssemblyInstruction.fold(
  //       (failure) => failure.maybeMap(
  //         notInstruction: (f) {
  //           print('was not an instruction');
  //         },
  //         valueTooLarge: (f) {
  //           print('the value was too large');
  //         },
  //         invalidAInstructionValue: (f) {
  //           print('A instructions value is incorrect');
  //         },
  //         invalidCInstructionDestination: (f) {
  //           print('C instructions destination is incorrect');
  //         },
  //         invalidCInstructionComputation: (f) {
  //           print('C instructions computation is incorrect');
  //         },
  //         invalidCInstructionJump: (f) {
  //           print('C instructions jump is incorrect');
  //         },
  //         orElse: () {
  //           print('An unexpected error has occured. Sorry about that...');
  //         },
  //       ),
  //       (instruction) {
  //         final failureOrMachineCodeInstruction =
  //             machineCodeTranslator.translate(instruction);
  //         failureOrMachineCodeInstruction.fold(
  //           (failure) => throw Exception('Failed to translate to Machine Code'),
  //           (machineCodeInstruction) {
  //             writer.write(machineCodeInstruction);
  //           },
  //         );
  //       },
  //     );
  //     lineNumber++;
  //   },
  // );
}

//TODO put in FileInParser
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
