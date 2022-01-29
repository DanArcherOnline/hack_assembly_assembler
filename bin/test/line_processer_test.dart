import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../di_setup.dart';
import '../line_processer.dart';
import 'line_processer_test.mocks.dart';

class Operation {
  void operation(String line) {}
}

@GenerateMocks([Operation])
void main() {
  configureDependencies();
  final lineProcesser = sl<LineProcesser>();

  group('processLine', () {
    test(
      'should run operation on each line of fixture_file.asm '
      'when processLine is called',
      () async {
        //arrange
        const fixturesLine1 = '1';
        const fixturesLine2 = '12';
        const fixturesLine3 = '123';
        final fixtureFilePath =
            '${Directory.current.path}/bin/test/fixtures/fixture_data.asm';
        final file = File(fixtureFilePath);
        final testOperation = MockOperation();
        //act
        await lineProcesser.processLines(
            file: file, lineOperation: testOperation.operation);
        //assert
        expect(verify(testOperation.operation(captureAny)).captured, [
          fixturesLine1,
          fixturesLine2,
          fixturesLine3,
        ]);
      },
    );
  });
}
