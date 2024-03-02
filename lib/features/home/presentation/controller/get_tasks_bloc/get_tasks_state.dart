import 'package:todo_with_firebase/features/home/data/task_model.dart';

abstract class TaskState {}

class LoadingTasksState extends TaskState {}
class InitialState extends TaskState {}
class ErrorState extends TaskState {}

class LoadedTasksState extends TaskState {
    List<TaskModel> tasks;

  LoadedTasksState(this.tasks);
}