// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'machine_code_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MachineCodeInstructionTearOff {
  const _$MachineCodeInstructionTearOff();

  _MachineCodeInstruction call({required String value}) {
    return _MachineCodeInstruction(
      value: value,
    );
  }
}

/// @nodoc
const $MachineCodeInstruction = _$MachineCodeInstructionTearOff();

/// @nodoc
mixin _$MachineCodeInstruction {
  String get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MachineCodeInstructionCopyWith<MachineCodeInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MachineCodeInstructionCopyWith<$Res> {
  factory $MachineCodeInstructionCopyWith(MachineCodeInstruction value,
          $Res Function(MachineCodeInstruction) then) =
      _$MachineCodeInstructionCopyWithImpl<$Res>;
  $Res call({String value});
}

/// @nodoc
class _$MachineCodeInstructionCopyWithImpl<$Res>
    implements $MachineCodeInstructionCopyWith<$Res> {
  _$MachineCodeInstructionCopyWithImpl(this._value, this._then);

  final MachineCodeInstruction _value;
  // ignore: unused_field
  final $Res Function(MachineCodeInstruction) _then;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$MachineCodeInstructionCopyWith<$Res>
    implements $MachineCodeInstructionCopyWith<$Res> {
  factory _$MachineCodeInstructionCopyWith(_MachineCodeInstruction value,
          $Res Function(_MachineCodeInstruction) then) =
      __$MachineCodeInstructionCopyWithImpl<$Res>;
  @override
  $Res call({String value});
}

/// @nodoc
class __$MachineCodeInstructionCopyWithImpl<$Res>
    extends _$MachineCodeInstructionCopyWithImpl<$Res>
    implements _$MachineCodeInstructionCopyWith<$Res> {
  __$MachineCodeInstructionCopyWithImpl(_MachineCodeInstruction _value,
      $Res Function(_MachineCodeInstruction) _then)
      : super(_value, (v) => _then(v as _MachineCodeInstruction));

  @override
  _MachineCodeInstruction get _value => super._value as _MachineCodeInstruction;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_MachineCodeInstruction(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_MachineCodeInstruction implements _MachineCodeInstruction {
  const _$_MachineCodeInstruction({required this.value});

  @override
  final String value;

  @override
  String toString() {
    return 'MachineCodeInstruction(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MachineCodeInstruction &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  _$MachineCodeInstructionCopyWith<_MachineCodeInstruction> get copyWith =>
      __$MachineCodeInstructionCopyWithImpl<_MachineCodeInstruction>(
          this, _$identity);
}

abstract class _MachineCodeInstruction implements MachineCodeInstruction {
  const factory _MachineCodeInstruction({required String value}) =
      _$_MachineCodeInstruction;

  @override
  String get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MachineCodeInstructionCopyWith<_MachineCodeInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}
