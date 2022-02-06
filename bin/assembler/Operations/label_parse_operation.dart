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
    await _lineProcesser.processLines(
        file: fileIn,
        lineOperation: (line) {
          if (waitingLabelCode.isNotEmpty &&
              _assemblyParser.minifyCode(line).isNotEmpty) {
            final prevLabelCode = waitingLabelCode.removeFirst();
            _labelParser.parseLabel(
              line: prevLabelCode,
              lineNumber: _lineTracker.currentCodeLineNumber,
            );
          }

          if (_labelParser.isValidLabel(line)) {
            waitingLabelCode.add(line);
          }

          _lineTracker.incrementLineCounters(
            isParsableCode: !_isWhitespaceOrComment(line),
          );
          return none();
        });
    if (waitingLabelCode.isNotEmpty) {
      final emptyLableCode = waitingLabelCode.removeFirst();
      print('🤮 empty label: $emptyLableCode');
      return some(InvalidLabelFailure(
        type: InvalidLabelType.unimplementedLabel,
        lineNumber: _lineTracker.currentLineNumber,
        line: waitingLabelCode.removeFirst(),
      ));
    }
    print('🤮 labelParser.debugSymbols: ${_labelParser.debugSymbols}');
    return none();
  }

  bool _isWhitespaceOrComment(String line) =>
      _assemblyParser.minifyCode(line).isEmpty;
}
