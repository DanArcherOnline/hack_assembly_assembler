import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../core/failure.dart';
import '../core/typedefs.dart';

@lazySingleton
class LineProcesser {
  Future<Option<Failure>> processLines({
    required File file,
    required LineOperation lineOperation,
  }) async {
    final lineStream =
        file.openRead().map(utf8.decode).transform(LineSplitter());
    await for (final line in lineStream) {
      final failureOption = lineOperation(line);
      if (failureOption.isSome()) {
        return failureOption;
      }
    }
    return none();
  }
}
