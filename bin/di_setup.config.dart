// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'a_instruction_parser.dart' as _i3;
import 'assembly_parser.dart' as _i6;
import 'c_instruction_parser.dart' as _i4;
import 'line_processer.dart' as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AInstructionParser>(() => _i3.AInstructionParser());
  gh.factory<_i4.CInstructionParser>(() => _i4.CInstructionParser());
  gh.lazySingleton<_i5.LineProcesser>(() => _i5.LineProcesser());
  gh.lazySingleton<_i6.AssemblyParser>(() => _i6.AssemblyParser(
      get<_i3.AInstructionParser>(), get<_i4.CInstructionParser>()));
  return get;
}
