import 'package:dartz/dartz.dart';
import 'package:todo_with_firebase/core/error/failure.dart';
import 'package:todo_with_firebase/features/home/data/task_model.dart';


abstract class BaseRepository {
  Future<Either< String, Failure>> addTaskToFirebase(TaskModel task);
  Future<Either< List<TaskModel>,Failure>> getTasks();

}
