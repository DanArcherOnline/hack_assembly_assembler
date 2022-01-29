import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';

import 'typedefs.dart';

@lazySingleton
class LineProcesser {
  Future<void> processLines({
    required File file,
    required LineOperation lineOperation,
  }) async {
    await file
        .openRead()
        .map(utf8.decode)
        .transform(LineSplitter())
        .forEach((line) => lineOperation(line));
  }
}
