import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:file/file.dart';
import 'package:injectable/injectable.dart';

import '../core/failure.dart';
import '../io/line_processer.dart';
import '../parsing/assembly_parser.dart';
import '../parsing/label_parser.dart';
import '../parsing/line_tracker.dart';
import 'operation.dart';

@injectable
class LabelParseOperation implements Operation {
  final LineProcesser _lineProcesser;
  final AssemblyParser _assemblyParser;
  final LabelParser _labelParser;
  final LineTracker _lineTracker;

  LabelParseOperation({
    required LineProcesser lineProcesser,
    required AssemblyParser assemblyParser,
    required LabelParser labelParser,
    required LineTracker lineTracker,
  })  : _lineProcesser = lineProcesser,
        _assemblyParser = assemblyParser,
        _labelParser = labelParser,
        _lineTracker = lineTracker;

  @override
  Future<Option<Failure>> run(File fileIn) async {
    final waitingLabelCode = Queue<String>();
    final failureOption = await _lineProcesser.processLines(
        file: fileIn,
        lineOperation: (line) {
          if (waitingLabelCode.isNotEmpty &&
              _assemblyParser.minifyCode(line).isNotEmpty) {
            final prevLabelCode = waitingLabelCode.removeFirst();
            final failureOption = _labelParser.parseLabel(
              line: prevLabelCode,
              lineNumber: _lineTracker.currentCodeLineNumber,
            );
            if (failureOption.isSome()) {
              return failureOption;
            }
          }

          if (_labelParser.isLabel(line)) {
            waitingLabelCode.add(line);
          }

          _lineTracker.incrementLineCounters(
            isParsableCode: !_isWhitespaceOrCommentOrLabel(line),
          );
          return none();
        });
    if (waitingLabelCode.isNotEmpty) {
      final emptyLableCode = waitingLabelCode.removeFirst();
      return some(InvalidLabelFailure(
        type: InvalidLabelType.unimplementedLabel,
        lineNumber: _lineTracker.currentLineNumber,
        line: emptyLableCode,
      ));
    }
    return failureOption;
  }

  bool _isWhitespaceOrCommentOrLabel(String line) =>
      _assemblyParser.minifyCode(line).isEmpty || _labelParser.isLabel(line);
}
