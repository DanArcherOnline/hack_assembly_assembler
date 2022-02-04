import 'package:injectable/injectable.dart';

@injectable
class LineTracker {
  int _currentLine = 0;

  int get currentLine => _currentLine;

  void incrementLineCount({required bool shouldIncrement}) {
    if (shouldIncrement) {
      _currentLine++;
    }
  }

  void resetLineCount() {
    _currentLine = 0;
  }
}
