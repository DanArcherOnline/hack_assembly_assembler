// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:file/file.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../test/test_modules.dart' as _i15;
import '../io/line_processer.dart' as _i5;
import '../io/machine_code_writer.dart' as _i9;
import '../Operations/label_parse_operation.dart' as _i14;
import '../parsing/a_instruction_parser.dart' as _i11;
import '../parsing/assembly_parser.dart' as _i12;
import '../parsing/c_instruction_parser.dart' as _i3;
import '../parsing/label_parser.dart' as _i13;
import '../parsing/line_tracker.dart' as _i6;
import '../parsing/symbols.dart' as _i10;
import '../translation/machine_code_instruction.dart' as _i7;
import '../translation/machine_code_translator.dart' as _i8;
import 'third_party_modules.dart' as _i16;

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
  gh.lazySingleton<_i4.FileSystem>(() => testModules.memoryFileSystem,
      registerFor: {_test});
  gh.lazySingleton<_i4.FileSystem>(() => thirdPartyModules.localFileSystem,
      registerFor: {_dev});
  gh.lazySingleton<_i5.LineProcesser>(() => _i5.LineProcesser());
  gh.factory<_i6.LineTracker>(() => _i6.LineTracker());
  gh.factory<_i7.MachineCodeInstruction>(
      () => _i7.MachineCodeInstruction(value: get<String>()));
  gh.lazySingleton<_i8.MachineCodeTranslator>(
      () => _i8.MachineCodeTranslator());
  gh.factoryParam<_i9.MachineCodeWriter, String?, dynamic>((filePathIn, _) =>
      _i9.MachineCodeWriter(
          fileSystem: get<_i4.FileSystem>(), filePathIn: filePathIn));
  gh.factory<_i10.Symbols>(() => testModules.symbols, registerFor: {_test});
  gh.lazySingleton<_i10.Symbols>(() => _i10.Symbols(), registerFor: {_dev});
  gh.factory<_i11.AInstructionParser>(
      () => _i11.AInstructionParser(symbols: get<_i10.Symbols>()));
  gh.lazySingleton<_i12.AssemblyParser>(() => _i12.AssemblyParser(
      get<_i11.AInstructionParser>(), get<_i3.CInstructionParser>()));
  gh.factory<_i13.LabelParser>(
      () => _i13.LabelParser(symbols: get<_i10.Symbols>()));
  gh.factory<_i14.LabelParseOperation>(() => _i14.LabelParseOperation(
      lineProcesser: get<_i5.LineProcesser>(),
      assemblyParser: get<_i12.AssemblyParser>(),
      labelParser: get<_i13.LabelParser>(),
      lineTracker: get<_i6.LineTracker>()));
  return get;
}

class _$TestModules extends _i15.TestModules {}

class _$ThirdPartyModules extends _i16.ThirdPartyModules {}
