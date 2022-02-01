// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:file/file.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'a_instruction_parser.dart' as _i3;
import 'assembly_parser.dart' as _i10;
import 'c_instruction_parser.dart' as _i4;
import 'line_processer.dart' as _i6;
import 'machine_code_instruction.dart' as _i7;
import 'machine_code_translator.dart' as _i8;
import 'machine_code_writer.dart' as _i9;
import 'test/third_party_test_modules.dart' as _i11;
import 'third_party_modules.dart' as _i12;

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
  gh.factory<_i3.AInstructionParser>(() => _i3.AInstructionParser());
  gh.factory<_i4.CInstructionParser>(() => _i4.CInstructionParser());
  gh.lazySingleton<_i5.FileSystem>(() => thirdPartyTestModules.memoryFileSystem,
      registerFor: {_test});
  gh.lazySingleton<_i5.FileSystem>(() => thirdPartyModules.localFileSystem,
      registerFor: {_dev});
  gh.lazySingleton<_i6.LineProcesser>(() => _i6.LineProcesser());
  gh.factory<_i7.MachineCodeInstruction>(
      () => _i7.MachineCodeInstruction(value: get<String>()));
  gh.lazySingleton<_i8.MachineCodeTranslator>(
      () => _i8.MachineCodeTranslator());
  gh.factoryParam<_i9.MachineCodeWriter, String?, dynamic>((filePathIn, _) =>
      _i9.MachineCodeWriter(
          fileSystem: get<_i5.FileSystem>(), filePathIn: filePathIn));
  gh.lazySingleton<_i10.AssemblyParser>(() => _i10.AssemblyParser(
      get<_i3.AInstructionParser>(), get<_i4.CInstructionParser>()));
  return get;
}

class _$ThirdPartyTestModules extends _i11.ThirdPartyTestModules {}

class _$ThirdPartyModules extends _i12.ThirdPartyModules {}
