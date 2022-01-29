import 'package:dartz/dartz.dart';

import 'failure.dart';
import 'instruction.dart';

typedef LineOperation = void Function(String);
typedef FailureOrInstruction = Either<Failure, Instruction>;
