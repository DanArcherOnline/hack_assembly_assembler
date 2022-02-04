import 'package:dartz/dartz.dart';
import 'package:file/file.dart';

import '../core/failure.dart';

abstract class Operation {
  Future<Option<Failure>> run(File file);
}
