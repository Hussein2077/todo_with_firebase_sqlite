import 'package:equatable/equatable.dart';

abstract class BaseSignInWithPlatformEvent extends Equatable {
  const BaseSignInWithPlatformEvent();

  @override
  List<Object> get props => [];
}


class AddTaskEvent extends BaseSignInWithPlatformEvent {
  final String taskName;
  final String dueDate;
  final int isDone;

  const AddTaskEvent({
    required this.taskName,
    required this.dueDate,
      this.isDone=0,
  });

}
