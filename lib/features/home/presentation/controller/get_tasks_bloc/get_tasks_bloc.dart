// Bloc, Events, and States remain similar to the previous example

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_firebase/core/error/failure.dart';
import 'package:todo_with_firebase/features/home/domain/use_case/get_tasks_use_case.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/get_tasks_bloc/get_tasks_event.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/get_tasks_bloc/get_tasks_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;

  TaskBloc(this.getTasksUseCase) : super(InitialState()) {
    on<LoadTasksEvent>(_onLoadTasks);
  }

  void _onLoadTasks(LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(LoadingTasksState());
    try {
      final eitherResult = await getTasksUseCase.execute();

      return eitherResult.fold(
        (l) => emit(LoadedTasksState(l)),
        (r) => emit(ErrorState()),
      );
    } catch (e) {
      return emit(ErrorState());
    }
  }
}
