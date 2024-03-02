import 'package:sqflite/sqlite_api.dart';
import 'package:todo_with_firebase/features/home/data/home_local_data_source.dart';
import 'package:todo_with_firebase/features/home/data/repo_imp.dart';
import 'package:todo_with_firebase/features/home/domain/repo/base_repo.dart';
import 'package:todo_with_firebase/features/home/domain/use_case/add_task_use_case.dart';
import 'package:todo_with_firebase/features/home/domain/use_case/get_tasks_use_case.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/get_tasks_bloc/get_tasks_bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/local%20blocs/database.bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/local%20blocs/todo.bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/tasks_bloc/add_task_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_with_firebase/features/home/data/home_remote_data_source.dart';

final getIt = GetIt.instance;

class ServerLocator {
  Future<void> init() async {
    //bloc

    getIt.registerLazySingleton(() => AddTaskBloc(addTaskUseCase: getIt()));
    getIt.registerLazySingleton(() => TaskBloc(getIt()));

//use_case
    getIt.registerFactory(() => AddTaskUseCase(baseRepository: getIt()));
    getIt.registerFactory(() => GetTasksUseCase(getIt()));
    //remote data
    getIt.registerLazySingleton<BaseRemotelyDataSource>(
        () => AuthRemotelyDateSource());

    // repo
    getIt.registerLazySingleton<BaseRepository>(() => RepositoryImp(
          baseRemotelyDataSource: getIt(),
        ));

  }
}
