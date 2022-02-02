import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'failure.dart';

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
  };

  Either<Failure, String> get(String key) {
    try {
      final symbol = _symbols[key]!;
      return right(symbol);
    } catch (_) {
      return left(SymbolDoesNotExistFailure());
    }
  }

  void put(String key, String symbol) {
    _symbols.putIfAbsent(key, () => _symbols[key] = symbol);
  }

  String _addThenGet(String key) {
    return '';
  }
}
