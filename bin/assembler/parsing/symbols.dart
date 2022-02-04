import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../core/failure.dart';

@dev
@lazySingleton
class Symbols {
  final Map<String, String> _symbols = {
    'R0': '0',
    'R1': '1',
    'R2': '2',
    'R3': '3',
    'R4': '4',
    'R5': '5',
    'R6': '6',
    'R7': '7',
    'R8': '8',
    'R9': '9',
    'R10': '10',
    'R11': '11',
    'R12': '12',
    'R13': '13',
    'R14': '14',
    'R15': '15',
    'SCREEN': '16384',
    'KBD': '24576',
    'SP': '0',
    'LCL': '1',
    'ARG': '2',
    'THIS': '3',
    'THAT': '4',
  };

  static const int customSymbolStartingVal = 16;
  int _currentCustomSymbolVal = customSymbolStartingVal;

  Either<Failure, String> get(String key) {
    if (_symbols.containsKey(key)) {
      return right(_symbols[key]!);
    }
    _symbols[key] = _currentCustomSymbolVal.toString();
    _currentCustomSymbolVal++;
    return right(_symbols[key]!);
  }

  Option<Failure> put(String key, String symbol) {
    if (_symbols.containsKey(key)) {
      return some(InvalidLabelFailure());
    }
    _symbols[key] = symbol;
    return none();
  }

  bool isValidKey(String symbolKey) =>
      RegExp(r'^[a-zA-Z]+.*').hasMatch(symbolKey);

  //TODO remove below debug getter
  Map<String, String> get debugSymbols => _symbols;
}
