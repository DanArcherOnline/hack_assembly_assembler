// import 'package:dartz/dartz.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:test/test.dart';

import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../assembler/core/environment.dart';
import '../assembler/core/failure.dart';
import '../assembler/core/service_locator.dart';
import '../assembler/parsing/a_instruction_parser.dart';
import '../assembler/parsing/assembly_instruction.dart';
import '../assembler/parsing/assembly_parser.dart';
import '../assembler/parsing/c_instruction_parser.dart';
import '../assembler/parsing/label_parser.dart';
import '../assembler/parsing/symbols.dart';
import 'any_named_args.dart';
import 'assembly_parser_test.mocks.dart';

@GenerateMocks([AInstructionParser, CInstructionParser])
void main() {
  configureDependencies(Env.test);
  late AssemblyParser assemblyParser;
  late MockAInstructionParser aInstructionParser;
  late MockCInstructionParser cInstructionParser;
  late LabelParser labelParser;
  late final aInstruction = AInstruction(value: '');
  late final cInstruction = CInstruction(
    destination: '',
    computation: '',
    jump: '',
  );
  // String get anyCodeArg => anyCodeArg;

  setUp(() {
    aInstructionParser = MockAInstructionParser();
    cInstructionParser = MockCInstructionParser();
    labelParser = LabelParser(symbols: Symbols());
    assemblyParser = AssemblyParser(
      aInstructionParser,
      cInstructionParser,
    );
  });

  group('parse', () {
    test(
      'should return an AInstruction from AInstrutionParser '
      'when the line parameter is a valid A instruction',
      () async {
        //arrange
        final line = '@3';
        when(aInstructionParser.isValid(any)).thenReturn(true);
        when(aInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).thenReturn(Right(aInstruction));
        //act
        final instruction = assemblyParser.parse(line: line, lineNumber: 0);
        //assert
        expect(instruction, right(aInstruction));
        verify(aInstructionParser.parse(
          minifiedCode: line,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).called(1);
        verifyNever(cInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
      },
    );

    test(
      'should return an CInstruction from CInstrutionParser '
      'when the line parameter is a valid C instruction',
      () async {
        //arrange
        final line = 'D=M';
        when(aInstructionParser.isValid(any)).thenReturn(false);
        when(cInstructionParser.isValid(any)).thenReturn(true);
        when(cInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).thenReturn(Right(cInstruction));
        //act
        final instruction = assemblyParser.parse(line: line, lineNumber: 0);
        //assert
        expect(instruction, right(cInstruction));
        verify(cInstructionParser.parse(
          minifiedCode: line,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).called(1);
        verifyNever(aInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
      },
    );

    test(
      'should return an AInstruction from AInstrutionParser '
      'when the line parameter contains a symbol',
      () async {
        //arrange
        final line = '@R3';
        when(aInstructionParser.isValid(any)).thenReturn(true);
        when(cInstructionParser.isValid(any)).thenReturn(false);
        when(aInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).thenReturn(Right(aInstruction));
        //act
        final instruction = assemblyParser.parse(line: line, lineNumber: 0);
        //assert
        expect(instruction, right(aInstruction));
        verify(aInstructionParser.parse(
          minifiedCode: line,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).called(1);
        verifyNever(cInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
      },
    );

    test(
      'should return an AInstruction from AInstrutionParser even '
      'when the line parameter contains white space',
      () async {
        //arrange
        final line = '    @     3           ';
        final trimedLine = '@3';
        when(aInstructionParser.isValid(any)).thenReturn(true);
        when(cInstructionParser.isValid(any)).thenReturn(false);
        when(aInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).thenReturn(Right(aInstruction));
        //act
        final instruction = assemblyParser.parse(line: line, lineNumber: 0);
        //assert
        expect(instruction, right(aInstruction));
        verify(aInstructionParser.parse(
          minifiedCode: trimedLine,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).called(1);
        verifyNever(cInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
      },
    );

    test(
      'should return an AInstruction from AInstrutionParser even '
      'when the line parameter has no value',
      () async {
        //arrange
        final line = '@';
        when(aInstructionParser.isValid(any)).thenReturn(true);
        when(cInstructionParser.isValid(any)).thenReturn(false);
        when(aInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).thenReturn(Right(aInstruction));
        //act
        final instruction = assemblyParser.parse(line: line, lineNumber: 0);
        //assert
        expect(instruction, right(aInstruction));
        verify(aInstructionParser.parse(
          minifiedCode: line,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).called(1);
        verifyNever(cInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
      },
    );

    test(
      'should return an CInstruction from CInstrutionParser even '
      'when the line parameter contains white space',
      () async {
        //arrange
        final line = '   D   =    M     ';
        final trimedLine = 'D=M';
        when(aInstructionParser.isValid(any)).thenReturn(false);
        when(cInstructionParser.isValid(any)).thenReturn(true);
        when(cInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).thenReturn(Right(cInstruction));
        //act
        final instruction = assemblyParser.parse(line: line, lineNumber: 0);
        //assert
        expect(instruction, right(cInstruction));
        verify(cInstructionParser.parse(
          minifiedCode: trimedLine,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).called(1);
        verifyNever(aInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
      },
    );

    test(
      'should return an CInstruction from CInstrutionParser even '
      'when the line parameter contains comments',
      () async {
        //arrange
        final line = 'D=M    //this is not code and should be //ignored!';
        final trimedLine = 'D=M';
        when(aInstructionParser.isValid(any)).thenReturn(false);
        when(cInstructionParser.isValid(any)).thenReturn(true);
        when(cInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).thenReturn(Right(cInstruction));
        //act
        final instruction = assemblyParser.parse(line: line, lineNumber: 0);
        //assert
        expect(instruction, right(cInstruction));
        verify(cInstructionParser.parse(
          minifiedCode: trimedLine,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        )).called(1);
        verifyNever(aInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
      },
    );

    test(
      'should return a NotInstrucitonFailure of type invalidSyntax '
      'when the line parameter is not a valid A or C Instruction',
      () async {
        //arrange
        final line = 'M=M-1ZZZZZ';
        final failure = NotInstructionFailure(
          type: NotInstructionType.invalidSyntax,
          lineNumber: 0,
          line: line,
        );
        when(aInstructionParser.isValid(any)).thenReturn(false);
        when(cInstructionParser.isValid(any)).thenReturn(false);
        //act
        final instruction = assemblyParser.parse(
          line: line,
          lineNumber: 0,
        );
        //assert
        expect(instruction, left(failure));
        verifyNever(aInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
        verifyNever(cInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
      },
    );
    test(
      'should return a NotInstrucitonFailure of type validNonCode'
      'when the line of code is all white space',
      () async {
        //arrange
        final line = '        ';
        final failure = NotInstructionFailure(
          type: NotInstructionType.validNonCode,
          lineNumber: 0,
          line: line,
        );
        when(aInstructionParser.isValid(any)).thenReturn(false);
        when(cInstructionParser.isValid(any)).thenReturn(false);
        //act
        final instruction = assemblyParser.parse(
          line: line,
          lineNumber: 0,
        );
        //assert
        expect(instruction, left(failure));
        verifyNever(aInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
        verifyNever(cInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
      },
    );
    test(
      'should return a NotInstrucitonFailure of type validNonCode'
      'when the line of code is a comment',
      () async {
        //arrange
        final line = ' // just a comment here. nothing to see.';
        final failure = NotInstructionFailure(
          type: NotInstructionType.validNonCode,
          lineNumber: 0,
          line: line,
        );
        when(aInstructionParser.isValid(any)).thenReturn(false);
        when(cInstructionParser.isValid(any)).thenReturn(false);
        //act
        final instruction = assemblyParser.parse(
          line: line,
          lineNumber: 0,
        );
        //assert
        expect(instruction, left(failure));
        verifyNever(aInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
        verifyNever(cInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
      },
    );
    test(
      'should return a NotInstrucitonFailure of type validNonCode'
      'when the line of code is empty',
      () async {
        //arrange
        final line = '';
        final failure = NotInstructionFailure(
          type: NotInstructionType.validNonCode,
          lineNumber: 0,
          line: line,
        );
        when(aInstructionParser.isValid(any)).thenReturn(false);
        when(cInstructionParser.isValid(any)).thenReturn(false);
        //act
        final instruction = assemblyParser.parse(
          line: line,
          lineNumber: 0,
        );
        //assert
        expect(instruction, left(failure));
        verifyNever(aInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
        verifyNever(cInstructionParser.parse(
          minifiedCode: anyMinifiedCodeArg,
          lineNumber: anyLineNumberArg,
          rawCode: anyRawCodeArg,
        ));
      },
    );
  });

  group('minify', () {
    test(
      'should remove all white space when called on an a raw assembly code string',
      () async {
        //arrange
        final rawAssemblyCodeWithWhiteSpace = '   @  56';
        final parsedAssemblyCodeWithWhiteSpace = '@56';
        //act
        final parsedCode =
            assemblyParser.minifyCode(rawAssemblyCodeWithWhiteSpace);
        //assert
        expect(parsedCode, parsedAssemblyCodeWithWhiteSpace);
      },
    );

    test(
      'should remove comment when called on an a raw assembly code string',
      () async {
        //arrange
        final rawAssemblyCodeWithComment = '@56 //comment in line';
        final parsedAssemblyCodeWithComment = '@56';
        //act
        final parsedCode =
            assemblyParser.minifyCode(rawAssemblyCodeWithComment);
        //assert
        expect(parsedCode, parsedAssemblyCodeWithComment);
      },
    );

    test(
      'should return an empty string when called on blank whitespace',
      () async {
        //arrange
        final blankWhitespace = '                  ';
        final emptyString = '';
        //act
        final parsedCode = assemblyParser.minifyCode(blankWhitespace);
        //assert
        expect(parsedCode, emptyString);
      },
    );

    test(
      'should return an empty string when called on an empty string',
      () async {
        //arrange
        final blankWhitespace = '';
        final emptyString = '';
        //act
        final parsedCode = assemblyParser.minifyCode(blankWhitespace);
        //assert
        expect(parsedCode, emptyString);
      },
    );
  });
}
