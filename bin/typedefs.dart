import 'package:dartz/dartz.dart';

import 'assembly_instruction.dart';
import 'failure.dart';
import 'machine_code_instruction.dart';

typedef LineOperation = void Function(String);
typedef FailureOrInstruction = Either<Failure, AssemblyInstruction>;
typedef FailureOrMachineCodeInstruction
    = Either<Failure, MachineCodeInstruction>;
