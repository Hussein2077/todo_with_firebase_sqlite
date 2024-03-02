import 'package:dartz/dartz.dart';
import 'package:todo_with_firebase/core/base_use_case/base_use_case.dart';
import 'package:todo_with_firebase/core/error/failure.dart';
import 'package:todo_with_firebase/features/home/data/task_model.dart';
import 'package:todo_with_firebase/features/home/domain/repo/base_repo.dart';
import 'package:todo_with_firebase/features/home/domain/repo/base_repo.dart';

class AddTaskUseCase extends BaseUseCase<String, TaskModel> {
  BaseRepository baseRepository;

  AddTaskUseCase({required this.baseRepository});

  @override
  Future<Either<String, Failure>> call(TaskModel parameter) async {
    final result = await baseRepository.addTaskToFirebase(parameter);

    return result;
  }
}
