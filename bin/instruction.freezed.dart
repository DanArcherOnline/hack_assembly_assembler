// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AssemblyInstructionTearOff {
  const _$AssemblyInstructionTearOff();

  AInstruction aInstruction({required String value}) {
    return AInstruction(
      value: value,
    );
  }

  CInstruction cInstruction(
      {String? destination, String? computation, String? jump}) {
    return CInstruction(
      destination: destination,
      computation: computation,
      jump: jump,
    );
  }
}

/// @nodoc
const $AssemblyInstruction = _$AssemblyInstructionTearOff();

/// @nodoc
mixin _$AssemblyInstruction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) aInstruction,
    required TResult Function(
            String? destination, String? computation, String? jump)
        cInstruction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String value)? aInstruction,
    TResult Function(String? destination, String? computation, String? jump)?
        cInstruction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? aInstruction,
    TResult Function(String? destination, String? computation, String? jump)?
        cInstruction,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AInstruction value) aInstruction,
    required TResult Function(CInstruction value) cInstruction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AInstruction value)? aInstruction,
    TResult Function(CInstruction value)? cInstruction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AInstruction value)? aInstruction,
    TResult Function(CInstruction value)? cInstruction,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssemblyInstructionCopyWith<$Res> {
  factory $AssemblyInstructionCopyWith(
          AssemblyInstruction value, $Res Function(AssemblyInstruction) then) =
      _$AssemblyInstructionCopyWithImpl<$Res>;
}

/// @nodoc
class _$AssemblyInstructionCopyWithImpl<$Res>
    implements $AssemblyInstructionCopyWith<$Res> {
  _$AssemblyInstructionCopyWithImpl(this._value, this._then);

  final AssemblyInstruction _value;
  // ignore: unused_field
  final $Res Function(AssemblyInstruction) _then;
}

/// @nodoc
abstract class $AInstructionCopyWith<$Res> {
  factory $AInstructionCopyWith(
          AInstruction value, $Res Function(AInstruction) then) =
      _$AInstructionCopyWithImpl<$Res>;
  $Res call({String value});
}

/// @nodoc
class _$AInstructionCopyWithImpl<$Res>
    extends _$AssemblyInstructionCopyWithImpl<$Res>
    implements $AInstructionCopyWith<$Res> {
  _$AInstructionCopyWithImpl(
      AInstruction _value, $Res Function(AInstruction) _then)
      : super(_value, (v) => _then(v as AInstruction));

  @override
  AInstruction get _value => super._value as AInstruction;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(AInstruction(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AInstruction implements AInstruction {
  const _$AInstruction({required this.value});

  @override
  final String value;

  @override
  String toString() {
    return 'AssemblyInstruction.aInstruction(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AInstruction &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  $AInstructionCopyWith<AInstruction> get copyWith =>
      _$AInstructionCopyWithImpl<AInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) aInstruction,
    required TResult Function(
            String? destination, String? computation, String? jump)
        cInstruction,
  }) {
    return aInstruction(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String value)? aInstruction,
    TResult Function(String? destination, String? computation, String? jump)?
        cInstruction,
  }) {
    return aInstruction?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? aInstruction,
    TResult Function(String? destination, String? computation, String? jump)?
        cInstruction,
    required TResult orElse(),
  }) {
    if (aInstruction != null) {
      return aInstruction(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AInstruction value) aInstruction,
    required TResult Function(CInstruction value) cInstruction,
  }) {
    return aInstruction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AInstruction value)? aInstruction,
    TResult Function(CInstruction value)? cInstruction,
  }) {
    return aInstruction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AInstruction value)? aInstruction,
    TResult Function(CInstruction value)? cInstruction,
    required TResult orElse(),
  }) {
    if (aInstruction != null) {
      return aInstruction(this);
    }
    return orElse();
  }
}

abstract class AInstruction implements AssemblyInstruction {
  const factory AInstruction({required String value}) = _$AInstruction;

  String get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AInstructionCopyWith<AInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CInstructionCopyWith<$Res> {
  factory $CInstructionCopyWith(
          CInstruction value, $Res Function(CInstruction) then) =
      _$CInstructionCopyWithImpl<$Res>;
  $Res call({String? destination, String? computation, String? jump});
}

/// @nodoc
class _$CInstructionCopyWithImpl<$Res>
    extends _$AssemblyInstructionCopyWithImpl<$Res>
    implements $CInstructionCopyWith<$Res> {
  _$CInstructionCopyWithImpl(
      CInstruction _value, $Res Function(CInstruction) _then)
      : super(_value, (v) => _then(v as CInstruction));

  @override
  CInstruction get _value => super._value as CInstruction;

  @override
  $Res call({
    Object? destination = freezed,
    Object? computation = freezed,
    Object? jump = freezed,
  }) {
    return _then(CInstruction(
      destination: destination == freezed
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String?,
      computation: computation == freezed
          ? _value.computation
          : computation // ignore: cast_nullable_to_non_nullable
              as String?,
      jump: jump == freezed
          ? _value.jump
          : jump // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CInstruction implements CInstruction {
  const _$CInstruction({this.destination, this.computation, this.jump});

  @override
  final String? destination;
  @override
  final String? computation;
  @override
  final String? jump;

  @override
  String toString() {
    return 'AssemblyInstruction.cInstruction(destination: $destination, computation: $computation, jump: $jump)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CInstruction &&
            (identical(other.destination, destination) ||
                const DeepCollectionEquality()
                    .equals(other.destination, destination)) &&
            (identical(other.computation, computation) ||
                const DeepCollectionEquality()
                    .equals(other.computation, computation)) &&
            (identical(other.jump, jump) ||
                const DeepCollectionEquality().equals(other.jump, jump)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(destination) ^
      const DeepCollectionEquality().hash(computation) ^
      const DeepCollectionEquality().hash(jump);

  @JsonKey(ignore: true)
  @override
  $CInstructionCopyWith<CInstruction> get copyWith =>
      _$CInstructionCopyWithImpl<CInstruction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) aInstruction,
    required TResult Function(
            String? destination, String? computation, String? jump)
        cInstruction,
  }) {
    return cInstruction(destination, computation, jump);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String value)? aInstruction,
    TResult Function(String? destination, String? computation, String? jump)?
        cInstruction,
  }) {
    return cInstruction?.call(destination, computation, jump);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? aInstruction,
    TResult Function(String? destination, String? computation, String? jump)?
        cInstruction,
    required TResult orElse(),
  }) {
    if (cInstruction != null) {
      return cInstruction(destination, computation, jump);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AInstruction value) aInstruction,
    required TResult Function(CInstruction value) cInstruction,
  }) {
    return cInstruction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AInstruction value)? aInstruction,
    TResult Function(CInstruction value)? cInstruction,
  }) {
    return cInstruction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AInstruction value)? aInstruction,
    TResult Function(CInstruction value)? cInstruction,
    required TResult orElse(),
  }) {
    if (cInstruction != null) {
      return cInstruction(this);
    }
    return orElse();
  }
}

abstract class CInstruction implements AssemblyInstruction {
  const factory CInstruction(
      {String? destination,
      String? computation,
      String? jump}) = _$CInstruction;

  String? get destination => throw _privateConstructorUsedError;
  String? get computation => throw _privateConstructorUsedError;
  String? get jump => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CInstructionCopyWith<CInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}
