import 'package:todo_with_firebase/core/base_use_case/base_use_case.dart';
import 'package:todo_with_firebase/features/home/data/task_model.dart';
import 'package:todo_with_firebase/features/home/domain/use_case/add_task_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_firebase/core/resource_manager/string_manager.dart';
import 'package:todo_with_firebase/core/utils/api_helper.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/tasks_bloc/add_task_events.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/tasks_bloc/add_task_states.dart';

class AddTaskBloc
    extends Bloc<BaseSignInWithPlatformEvent, AddTaskState> {
  final AddTaskUseCase addTaskUseCase;

  AddTaskBloc({
    required this.addTaskUseCase,
  }) : super(AddTaskInitial()) {
    on<AddTaskEvent>((event, emit) async {
      emit(const AddTaskLoadingState());
      final result = await addTaskUseCase.call(TaskModel(
        taskName: event.taskName,
        dueDate: event.dueDate,
        isDone: event.isDone,
      ));
      result.fold(
          (l) => emit(const AddTaskSuccessMessageState(
              successMessage: StringManager.loginSuccessfully)),
          (r) => emit(AddTaskErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
