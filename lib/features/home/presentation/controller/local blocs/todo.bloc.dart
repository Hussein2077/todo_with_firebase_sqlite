import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sqflite/sqlite_api.dart';
import 'package:todo_with_firebase/features/home/data/home_local_data_source.dart';
import 'package:todo_with_firebase/features/home/data/task_model.dart';
import 'package:todo_with_firebase/features/home/data/task_model.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/local%20blocs/todo.state.dart';

class TodoBloc extends Cubit<TodoState> {

  final _todoRepo = TodoRepository();
  final Database database;
  TodoBloc({required this.database}) : super(const InitTodoState(0));

  int _counter = 1;
  List<TaskModel> todos = [];
  // List<TaskModel> get todos => _todos;
  static TodoBloc get(context) => BlocProvider.of(context);
  Future<void> getTodos() async {
    try {
      todos = await _todoRepo.getTodos(database: database);
      emit(InitTodoState(_counter++));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addTodos(TaskModel taskModel) async {
    try {
      await _todoRepo.addTodo(database: database, taskModel: taskModel);
      emit(InitTodoState(_counter++));
      getTodos();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeTodo(int id) async {
    try {
      await _todoRepo.removeTodo(database: database, id: id);
      emit(InitTodoState(_counter++));
      getTodos();
    } catch (e) {
      log(e.toString());
    }
  }
}