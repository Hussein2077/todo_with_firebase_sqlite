import 'package:dartz/dartz.dart';
import 'package:todo_with_firebase/core/error/failure.dart';
import 'package:todo_with_firebase/core/utils/api_helper.dart';
import 'package:todo_with_firebase/features/home/data/home_local_data_source.dart';
import 'package:todo_with_firebase/features/home/data/home_remote_data_source.dart';
import 'package:todo_with_firebase/features/home/data/task_model.dart';
import 'package:todo_with_firebase/features/home/domain/repo/base_repo.dart';

class RepositoryImp extends BaseRepository {
  final BaseRemotelyDataSource baseRemotelyDataSource;

  RepositoryImp({
    required this.baseRemotelyDataSource,
  });

  @override
  Future<Either<String, Failure>> addTaskToFirebase(TaskModel task) async {
    try {
      final result = await baseRemotelyDataSource.addTaskToFirebase(task);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<TaskModel>, Failure>> getTasks() async {
    try {
      final tasks = await baseRemotelyDataSource.getTasks();
      return Left(tasks);
    } catch (e) {
      return Right(ServerFailure());
    }
  }

}
