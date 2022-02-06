import 'package:injectable/injectable.dart';

@injectable
class LineTracker {
  int _currentLineNumber = 1;
  int _currentCodeLineNumber = 0;

  int get currentLineNumber => _currentLineNumber;
  int get currentCodeLineNumber => _currentCodeLineNumber;

  void incrementLineCounters({required bool isParsableCode}) {
    _currentLineNumber++;
    if (isParsableCode) {
      _currentCodeLineNumber++;
    }
  }

  void resetLineCounters() {
    _currentLineNumber = 0;
    _currentCodeLineNumber = 0;
  }
}
