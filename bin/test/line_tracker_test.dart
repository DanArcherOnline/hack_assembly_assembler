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
  group('incrementLineCounters', () {
    test(
      'should increment currentLineNumber when isWhitespaceORComment is true',
      () async {
        //arrange
        //act
        for (var i = 0; i < 10; i++) {
          lineTracker.incrementLineCounters(isParsableCode: true);
        }
        //assert
        expect(lineTracker.currentLineNumber, 11);
      },
    );

    test(
      'should increment currentLineNumber when isWhitespaceORComment is false',
      () async {
        //arrange
        //act
        for (var i = 0; i < 10; i++) {
          lineTracker.incrementLineCounters(isParsableCode: false);
        }
        //assert
        expect(lineTracker.currentLineNumber, 11);
      },
    );
    test(
      'should not increment currentCodeLineNumber when isParsableCode is false',
      () async {
        //arrange
        //act
        for (var i = 0; i < 10; i++) {
          lineTracker.incrementLineCounters(isParsableCode: false);
        }
        //assert
        expect(lineTracker.currentCodeLineNumber, 0);
      },
    );

    test(
      'should increment currentCodeLineNumber when isParsableCode is true',
      () async {
        //arrange
        //act
        for (var i = 0; i < 10; i++) {
          lineTracker.incrementLineCounters(isParsableCode: true);
        }
        //assert
        expect(lineTracker.currentCodeLineNumber, 10);
      },
    );
  });

  group('resetLineCounters', () {
    test(
      'should set currentLineNumber to 0',
      () async {
        //arrange
        for (var i = 0; i < 10; i++) {
          lineTracker.incrementLineCounters(isParsableCode: true);
        }
        //act
        lineTracker.resetLineCounters();
        //assert
        expect(lineTracker.currentLineNumber, 0);
      },
    );
    test(
      'should set currentCodeLineNumber to 0',
      () async {
        //arrange
        for (var i = 0; i < 10; i++) {
          lineTracker.incrementLineCounters(isParsableCode: true);
        }
        //act
        lineTracker.resetLineCounters();
        //assert
        expect(lineTracker.currentCodeLineNumber, 0);
      },
    );
  });
}
