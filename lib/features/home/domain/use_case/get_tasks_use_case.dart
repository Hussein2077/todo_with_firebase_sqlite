import 'package:dartz/dartz.dart';
import 'package:todo_with_firebase/core/error/failure.dart';
import 'package:todo_with_firebase/features/home/data/task_model.dart';
import 'package:todo_with_firebase/features/home/domain/repo/base_repo.dart';

class GetTasksUseCase {
  final BaseRepository baseRepository;

  GetTasksUseCase(this.baseRepository);

  Future<Either< List<TaskModel>,Failure>>execute() {
    return baseRepository.getTasks();
  }
}