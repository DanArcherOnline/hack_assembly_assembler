import 'package:dartz/dartz.dart';
import 'package:file/src/interface/file.dart';

import '../core/error_parser.dart';
import '../core/failure.dart';
import '../io/line_processer.dart';
import '../io/machine_code_writer.dart';
import '../parsing/assembly_parser.dart';
import '../parsing/label_parser.dart';
import '../parsing/line_tracker.dart';
import '../translation/machine_code_translator.dart';
import 'operation.dart';

class TranslateOperation implements Operation {
  final LineProcesser _lineProcesser;
  final AssemblyParser _assemblyParser;
  final MachineCodeTranslator _translator;
  final MachineCodeWriter _writer;
  final LineTracker _lineTracker;
  final ErrorParser _errorParser;
  final LabelParser _labelParser;

  TranslateOperation(
    AssemblyParser assemblyParser,
    MachineCodeTranslator translator,
    MachineCodeWriter writer,
    LineProcesser lineProcesser,
    LineTracker lineTracker,
    LabelParser labelParser,
    ErrorParser errorParser,
  )   : _errorParser = errorParser,
        _lineProcesser = lineProcesser,
        _lineTracker = lineTracker,
        _assemblyParser = assemblyParser,
        _translator = translator,
        _labelParser = labelParser,
        _writer = writer;

  @override
  Future<Option<Failure>> run(File file) async {
    return await _lineProcesser.processLines(
      file: file,
      lineOperation: (line) {
        if (_labelParser.isLabel(line)) {
          return none<Failure>();
        }
        final failureOrAssemblyInstruction = _assemblyParser.parse(
          line: line,
          lineNumber: _lineTracker.currentLineNumber,
        );
        final failureOption = failureOrAssemblyInstruction.fold(
          (failure) {
            _errorParser.parse(failure: failure);
            return failure.maybeMap(
              notInstruction: (notInstruction) {
                if (notInstruction.type == NotInstructionType.validNonCode) {
                  return none<Failure>();
                }
                return some(failure);
              },
              orElse: () => some(failure),
            );
          },
          (assemblyInstruction) {
            final failureOrMachineCodeInstruction = _translator.translate(
              instruction: assemblyInstruction,
              lineNumber: _lineTracker.currentLineNumber,
              line: line,
            );
            return failureOrMachineCodeInstruction.fold(
              (failure) => some(failure),
              (machhineCodeInstruction) {
                _writer.write(machhineCodeInstruction);
                return none<Failure>();
              },
            );
          },
        );
        _lineTracker.incrementLineCounters(
            isParsableCode: !_isWhiteSpaceOrCommentOrLabel(line));
        return failureOption;
      },
    );
  }

  bool _isWhiteSpaceOrCommentOrLabel(String line) {
    return _assemblyParser.minifyCode(line).isEmpty ||
        _labelParser.isLabel(line);
  }
}
