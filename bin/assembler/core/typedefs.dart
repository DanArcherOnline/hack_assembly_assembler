import 'package:dartz/dartz.dart';

import '../parsing/assembly_instruction.dart';
import '../translation/machine_code_instruction.dart';
import 'failure.dart';

typedef LineOperation = Option<Failure> Function(String);
typedef FailureOrInstruction = Either<Failure, AssemblyInstruction>;
typedef FailureOrMachineCodeInstruction
    = Either<Failure, MachineCodeInstruction>;
