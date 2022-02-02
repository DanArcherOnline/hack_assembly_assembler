// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:file/file.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'a_instruction_parser.dart' as _i10;
import 'assembly_parser.dart' as _i11;
import 'c_instruction_parser.dart' as _i3;
import 'line_processer.dart' as _i5;
import 'machine_code_instruction.dart' as _i6;
import 'machine_code_translator.dart' as _i7;
import 'machine_code_writer.dart' as _i8;
import 'symbols.dart' as _i9;
import 'test/third_party_test_modules.dart' as _i12;
import 'third_party_modules.dart' as _i13;

const String _test = 'test';
const String _dev = 'dev';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyTestModules = _$ThirdPartyTestModules();
  final thirdPartyModules = _$ThirdPartyModules();
  gh.factory<_i3.CInstructionParser>(() => _i3.CInstructionParser());
  gh.lazySingleton<_i4.FileSystem>(() => thirdPartyTestModules.memoryFileSystem,
      registerFor: {_test});
  gh.lazySingleton<_i4.FileSystem>(() => thirdPartyModules.localFileSystem,
      registerFor: {_dev});
  gh.lazySingleton<_i5.LineProcesser>(() => _i5.LineProcesser());
  gh.factory<_i6.MachineCodeInstruction>(
      () => _i6.MachineCodeInstruction(value: get<String>()));
  gh.lazySingleton<_i7.MachineCodeTranslator>(
      () => _i7.MachineCodeTranslator());
  gh.factoryParam<_i8.MachineCodeWriter, String?, dynamic>((filePathIn, _) =>
      _i8.MachineCodeWriter(
          fileSystem: get<_i4.FileSystem>(), filePathIn: filePathIn));
  gh.factory<_i9.Symbols>(() => thirdPartyTestModules.symbols,
      registerFor: {_test});
  gh.lazySingleton<_i9.Symbols>(() => _i9.Symbols(), registerFor: {_dev});
  gh.factory<_i10.AInstructionParser>(
      () => _i10.AInstructionParser(symbols: get<_i9.Symbols>()));
  gh.lazySingleton<_i11.AssemblyParser>(() => _i11.AssemblyParser(
      get<_i10.AInstructionParser>(), get<_i3.CInstructionParser>()));
  return get;
}

class _$ThirdPartyTestModules extends _i12.ThirdPartyTestModules {}

class _$ThirdPartyModules extends _i13.ThirdPartyModules {}
