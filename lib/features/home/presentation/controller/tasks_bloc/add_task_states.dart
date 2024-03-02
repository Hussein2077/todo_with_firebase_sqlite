import 'package:equatable/equatable.dart';

abstract class AddTaskState extends Equatable {
  const AddTaskState();

  @override
  List<Object> get props => [];
}

class AddTaskInitial extends AddTaskState {}

class AddTaskLoadingState extends AddTaskState {
  const AddTaskLoadingState();
}

class AddTaskErrorMessageState extends AddTaskState {
  final String errorMessage;

  const AddTaskErrorMessageState({required this.errorMessage});
}

class AddTaskSuccessMessageState extends AddTaskState {
  final String successMessage;

  const AddTaskSuccessMessageState({required this.successMessage});
}
