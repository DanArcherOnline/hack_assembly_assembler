import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../assembler/core/environment.dart';
import '../assembler/core/service_locator.dart';
import '../assembler/parsing/line_tracker.dart';

void main() {
  configureDependencies(Env.test);
  late LineTracker lineTracker;

  setUp(() {
    lineTracker = sl<LineTracker>();
  });
  group('incrementLineCount', () {
    test(
      'should increment currentLine when shouldIncrement is true',
      () async {
        //arrange
        //act
        for (var i = 0; i < 10; i++) {
          lineTracker.incrementLineCount(shouldIncrement: true);
        }
        //assert
        expect(lineTracker.currentLine, 10);
      },
    );

    test(
      'should not increment currentLine when shouldIncrement is true',
      () async {
        //arrange
        //act
        for (var i = 0; i < 10; i++) {
          lineTracker.incrementLineCount(shouldIncrement: false);
        }
        //assert
        expect(lineTracker.currentLine, 0);
      },
    );
  });

  group('resetLine/count', () {
    test(
      'should set currentLine to 0',
      () async {
        //arrange
        for (var i = 0; i < 10; i++) {
          lineTracker.incrementLineCount(shouldIncrement: true);
        }
        //act
        lineTracker.resetLineCount();
        //assert
        expect(lineTracker.currentLine, 0);
      },
    );
  });
}
