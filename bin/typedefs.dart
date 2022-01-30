import 'package:dartz/dartz.dart';

import 'failure.dart';
import 'instruction.dart';
import 'machine_code_instruction.dart';

typedef LineOperation = void Function(String);
typedef FailureOrInstruction = Either<Failure, AssemblyInstruction>;
typedef FailureOrMachineCodeInstruction
    = Either<Failure, MachineCodeInstruction>;
