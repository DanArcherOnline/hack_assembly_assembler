// Mocks generated by Mockito 5.0.17 from annotations
// in hack_to_machine_assmebler/bin/test/a_instruction_parser_test.dart.
// Do not manually edit this file.

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

import '../failure.dart' as _i4;
import '../symbols.dart' as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [Symbols].
///
/// See the documentation for Mockito's code generation for more information.
class MockSymbols extends _i1.Mock implements _i3.Symbols {
  MockSymbols() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Either<_i4.Failure, String> get(String? key) =>
      (super.noSuchMethod(Invocation.method(#get, [key]),
              returnValue: _FakeEither_0<_i4.Failure, String>())
          as _i2.Either<_i4.Failure, String>);
  @override
  void put(String? key, String? symbol) =>
      super.noSuchMethod(Invocation.method(#put, [key, symbol]),
          returnValueForMissingStub: null);
}
