// Mocks generated by Mockito 5.0.17 from annotations
// in hack_to_machine_assmebler/bin/test/a_instruction_parser_test.dart.
// Do not manually edit this file.

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

import '../a_instruction_parser.dart' as _i3;
import '../assembly_instruction.dart' as _i5;
import '../c_instruction_parser.dart' as _i6;
import '../failure.dart' as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [AInstructionParser].
///
/// See the documentation for Mockito's code generation for more information.
class MockAInstructionParser extends _i1.Mock
    implements _i3.AInstructionParser {
  MockAInstructionParser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool isValid(String? code) => (super
          .noSuchMethod(Invocation.method(#isValid, [code]), returnValue: false)
      as bool);
  @override
  _i2.Either<_i4.Failure, _i5.AssemblyInstruction> parse(String? code) =>
      (super.noSuchMethod(Invocation.method(#parse, [code]),
              returnValue:
                  _FakeEither_0<_i4.Failure, _i5.AssemblyInstruction>())
          as _i2.Either<_i4.Failure, _i5.AssemblyInstruction>);
}

/// A class which mocks [CInstructionParser].
///
/// See the documentation for Mockito's code generation for more information.
class MockCInstructionParser extends _i1.Mock
    implements _i6.CInstructionParser {
  MockCInstructionParser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Either<_i4.Failure, _i5.AssemblyInstruction> parse(String? code) =>
      (super.noSuchMethod(Invocation.method(#parse, [code]),
              returnValue:
                  _FakeEither_0<_i4.Failure, _i5.AssemblyInstruction>())
          as _i2.Either<_i4.Failure, _i5.AssemblyInstruction>);
  @override
  bool isValid(String? code) => (super
          .noSuchMethod(Invocation.method(#isValid, [code]), returnValue: false)
      as bool);
}
