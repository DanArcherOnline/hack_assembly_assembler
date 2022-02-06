// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:file/file.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../test/test_modules.dart' as _i16;
import '../io/line_processer.dart' as _i6;
import '../io/machine_code_writer.dart' as _i10;
import '../Operations/label_parse_operation.dart' as _i15;
import '../parsing/a_instruction_parser.dart' as _i12;
import '../parsing/assembly_parser.dart' as _i13;
import '../parsing/c_instruction_parser.dart' as _i3;
import '../parsing/label_parser.dart' as _i14;
import '../parsing/line_tracker.dart' as _i7;
import '../parsing/symbols.dart' as _i11;
import '../translation/machine_code_instruction.dart' as _i8;
import '../translation/machine_code_translator.dart' as _i9;
import 'error_parser.dart' as _i4;
import 'third_party_modules.dart' as _i17;

const String _test = 'test';
const String _dev = 'dev';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final testModules = _$TestModules();
  final thirdPartyModules = _$ThirdPartyModules();
  gh.factory<_i3.CInstructionParser>(() => _i3.CInstructionParser());
  gh.factory<_i4.ErrorParser>(() => _i4.ErrorParser());
  gh.lazySingleton<_i5.FileSystem>(() => testModules.memoryFileSystem,
      registerFor: {_test});
  gh.lazySingleton<_i5.FileSystem>(() => thirdPartyModules.localFileSystem,
      registerFor: {_dev});
  gh.lazySingleton<_i6.LineProcesser>(() => _i6.LineProcesser());
  gh.factory<_i7.LineTracker>(() => _i7.LineTracker());
  gh.factory<_i8.MachineCodeInstruction>(
      () => _i8.MachineCodeInstruction(value: get<String>()));
  gh.lazySingleton<_i9.MachineCodeTranslator>(
      () => _i9.MachineCodeTranslator());
  gh.factoryParam<_i10.MachineCodeWriter, String?, dynamic>((filePathIn, _) =>
      _i10.MachineCodeWriter(
          fileSystem: get<_i5.FileSystem>(), filePathIn: filePathIn));
  gh.factory<_i11.Symbols>(() => testModules.symbols, registerFor: {_test});
  gh.lazySingleton<_i11.Symbols>(() => _i11.Symbols(), registerFor: {_dev});
  gh.factory<_i12.AInstructionParser>(
      () => _i12.AInstructionParser(symbols: get<_i11.Symbols>()));
  gh.lazySingleton<_i13.AssemblyParser>(() => _i13.AssemblyParser(
      get<_i12.AInstructionParser>(), get<_i3.CInstructionParser>()));
  gh.factory<_i14.LabelParser>(
      () => _i14.LabelParser(symbols: get<_i11.Symbols>()));
  gh.factory<_i15.LabelParseOperation>(() => _i15.LabelParseOperation(
      lineProcesser: get<_i6.LineProcesser>(),
      assemblyParser: get<_i13.AssemblyParser>(),
      labelParser: get<_i14.LabelParser>(),
      lineTracker: get<_i7.LineTracker>()));
  return get;
}

class _$TestModules extends _i16.TestModules {}

class _$ThirdPartyModules extends _i17.ThirdPartyModules {}
