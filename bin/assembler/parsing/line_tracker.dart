import 'package:injectable/injectable.dart';

@injectable
class LineTracker {
  //TODO also track validCodeLine
  //TODO change currentLine to currentFileLine
  int _currentLineNumber = 1;
  int _currentCodeLineNumber = 0;

  int get currentLineNumber => _currentLineNumber;
  int get currentCodeLineNumber => _currentCodeLineNumber;

  //TODO change test func name, test new logic
  void incrementLineCounters({required bool isParsableCode}) {
    _currentLineNumber++;
    if (isParsableCode) {
      _currentCodeLineNumber++;
    }
  }

  //TODO change test func name, test new logic
  void resetLineCounters() {
    _currentLineNumber = 0;
    _currentCodeLineNumber = 0;
  }
}
