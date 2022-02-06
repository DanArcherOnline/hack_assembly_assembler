import 'package:args/args.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:file/file.dart';

import 'Operations/label_parse_operation.dart';
import 'Operations/translate_operation.dart';
import 'core/environment.dart';
import 'core/error_parser.dart';
import 'core/exceptions.dart';
import 'core/failure.dart';
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
  final errorParser = sl<ErrorParser>();
  try {
    final path = getFileName(arguments);
    final fileSystem = sl<FileSystem>();
    final fileIn = fileSystem.file(path);
    final labelParseOperation = sl<LabelParseOperation>();
    final lineTracker = sl<LineTracker>();
    final lineProcesser = sl<LineProcesser>();
    final assemblyParser = sl<AssemblyParser>();
    final translator = sl<MachineCodeTranslator>();
    final labelParser = sl<LabelParser>();
    final writer =
        MachineCodeWriter(fileSystem: fileSystem, filePathIn: fileIn.path);
    final translateOperation = TranslateOperation(
      assemblyParser,
      translator,
      writer,
      lineProcesser,
      lineTracker,
      labelParser,
      errorParser,
    );
    final labelParseFailure = await labelParseOperation.run(fileIn);
    printErrorMessage(labelParseFailure, errorParser);
    if (labelParseFailure.isSome()) return;
    final translationFailure = await translateOperation.run(fileIn);
    printErrorMessage(translationFailure, errorParser);
    if (translationFailure.isSome()) return;
  } on InvalidFilePathExtensionException {
    printErrorMessageOnException(
      errorParser: errorParser,
      failure: InvalidFilePathFailure(
        type: InvalidFilePathType.invalidFileExtension,
        lineNumber: -1,
        line: '',
      ),
    );
  } on NoFilePathException {
    printErrorMessageOnException(
      errorParser: errorParser,
      failure: InvalidFilePathFailure(
        type: InvalidFilePathType.noFilePath,
        lineNumber: -1,
        line: '',
      ),
    );
  }
}

void printErrorMessageOnException({
  required ErrorParser errorParser,
  required Failure failure,
}) {
  final message = errorParser.parse(failure: failure);
  if (message != null) print(message);
}

void printErrorMessage(
    dartz.Option<Failure> labelParseFailure, ErrorParser errorParser) {
  if (labelParseFailure.isSome()) {
    labelParseFailure.flatMap((failure) {
      final err = errorParser.parse(failure: failure);
      if (err != null) print(err);
      return dartz.none();
    });
  }
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
