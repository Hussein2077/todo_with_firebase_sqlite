import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_with_firebase/core/error/failure.dart';

abstract class BaseUseCase<T, Parameter> {
  Future<Either<T, Failure>> call(Parameter parameter);
}

class NoParameter extends Equatable {
  const NoParameter();

  @override
  List<Object?> get props => [];
}
