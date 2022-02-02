import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../a_instruction_parser.dart';
import '../assembly_instruction.dart';
import '../assembly_parser.dart';
import '../c_instruction_parser.dart';
import '../environment.dart';
import '../failure.dart';
import '../service_locator.dart';
import 'assembly_parser_test.mocks.dart';

@GenerateMocks([AInstructionParser, CInstructionParser])
void main() {
  configureDependencies(Env.test);
  late AssemblyParser assemblyParser;
  late MockAInstructionParser aInstructionParser;
  late MockCInstructionParser cInstructionParser;
  late final aInstruction = AInstruction(value: '');
  late final cInstruction = CInstruction(
    destination: '',
    computation: '',
    jump: '',
  );

  setUp(() {
    aInstructionParser = MockAInstructionParser();
    cInstructionParser = MockCInstructionParser();
    assemblyParser = AssemblyParser(aInstructionParser, cInstructionParser);
  });

  group('parse', () {
    test(
      'should return an AInstruction from AInstrutionParser '
      'when the line parameter is a valid A instruction',
      () async {
        //arrange
        final line = '@3';
        when(aInstructionParser.isValid(any)).thenReturn(true);
        when(aInstructionParser.parse(any)).thenReturn(Right(aInstruction));
        //act
        final instruction = assemblyParser.parse(line);
        //assert
        expect(instruction, right(aInstruction));
        verify(aInstructionParser.parse(line)).called(1);
        verifyNever(cInstructionParser.parse(any));
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
        when(cInstructionParser.parse(any)).thenReturn(Right(cInstruction));
        //act
        final instruction = assemblyParser.parse(line);
        //assert
        expect(instruction, right(cInstruction));
        verify(cInstructionParser.parse(line)).called(1);
        verifyNever(aInstructionParser.parse(any));
      },
    );

    //TODO maybe change
    test(
      'should return an AInstruction from AInstrutionParser '
      'when the line parameter contains a symbol',
      () async {
        //arrange
        final line = '@R3';
        when(aInstructionParser.isValid(any)).thenReturn(true);
        when(cInstructionParser.isValid(any)).thenReturn(false);
        when(aInstructionParser.parse(any)).thenReturn(Right(aInstruction));
        //act
        final instruction = assemblyParser.parse(line);
        //assert
        expect(instruction, right(aInstruction));
        verify(aInstructionParser.parse(line)).called(1);
        verifyNever(cInstructionParser.parse(any));
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
        when(aInstructionParser.parse(any)).thenReturn(Right(aInstruction));
        //act
        final instruction = assemblyParser.parse(line);
        //assert
        expect(instruction, right(aInstruction));
        verify(aInstructionParser.parse(trimedLine)).called(1);
        verifyNever(cInstructionParser.parse(any));
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
        when(aInstructionParser.parse(any)).thenReturn(Right(aInstruction));
        //act
        final instruction = assemblyParser.parse(line);
        //assert
        expect(instruction, right(aInstruction));
        verify(aInstructionParser.parse(line)).called(1);
        verifyNever(cInstructionParser.parse(any));
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
        when(cInstructionParser.parse(any)).thenReturn(Right(cInstruction));
        //act
        final instruction = assemblyParser.parse(line);
        //assert
        expect(instruction, right(cInstruction));
        verify(cInstructionParser.parse(trimedLine)).called(1);
        verifyNever(aInstructionParser.parse(any));
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
        when(cInstructionParser.parse(any)).thenReturn(Right(cInstruction));
        //act
        final instruction = assemblyParser.parse(line);
        //assert
        expect(instruction, right(cInstruction));
        verify(cInstructionParser.parse(trimedLine)).called(1);
        verifyNever(aInstructionParser.parse(any));
      },
    );

    test(
      'should return a NotInstrucitonFailure '
      'when the line parameter is not a valid A or C Instruction; ',
      () async {
        //arrange
        final failure = NotInstructionFailure();
        when(aInstructionParser.isValid(any)).thenReturn(false);
        when(cInstructionParser.isValid(any)).thenReturn(false);
        //act
        final instruction = assemblyParser.parse('M=M-1ZZZZZ');
        //assert
        expect(instruction, left(failure));
        verifyNever(aInstructionParser.parse(any));
        verifyNever(cInstructionParser.parse(any));
      },
    );
  });
}
