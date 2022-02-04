import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../assembler/core/environment.dart';
import '../assembler/core/service_locator.dart';
import '../assembler/io/line_processer.dart';
import 'line_processer_test.mocks.dart';

abstract class TestFuncs {
  void func(String line);
}

@GenerateMocks([TestFuncs])
void main() {
  configureDependencies(Env.test);
  final lineProcesser = sl<LineProcesser>();

  group('processLine', () {
    test(
      'should run operation on each line of fixture_file.asm '
      'when processLine is called',
      () async {
        //arrange
        const fixturesLine1 = '@256';
        const fixturesLine2 = 'D=A';
        const fixturesLine3 = '0;JMP';
        final fixtureFilePath =
            '${Directory.current.path}/bin/test/fixtures/fixture_data.asm';
        final file = File(fixtureFilePath);
        final testOperation = MockTestFuncs();
        //act
        await lineProcesser.processLines(
            file: file, lineOperation: testOperation.func);
        //assert
        expect(verify(testOperation.func(captureAny)).captured, [
          fixturesLine1,
          fixturesLine2,
          fixturesLine3,
        ]);
      },
    );
  });
}
