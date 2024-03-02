import 'dart:developer';

import 'package:sqflite/sqlite_api.dart';
import 'package:todo_with_firebase/features/home/data/task_model.dart';

class TodoRepository {
  Future<List<TaskModel>> getTodos({
    required Database database,
  }) async {
    final data = await database.rawQuery('SELECT * FROM todo');
    List<TaskModel> todos = [];
    for (var item in data) {
      todos.add(TaskModel(
        id: item['id'].toString(),
        taskName: item['name'].toString(),
        dueDate: item['dueDate'].toString(),
        isDone: item['isDone'] as int,
      ));
    }
    return todos;
  }

  Future<dynamic> addTodo({
    required Database database,
    required TaskModel taskModel,
  }) async {
    log('${taskModel.taskName}taskModel.taskName');
    return await database.transaction((txn) async {
      await txn.rawInsert(
          "INSERT INTO todo (name, dueDate, isDone) VALUES ('${taskModel.taskName}','${taskModel.dueDate}',${taskModel.isDone})");

    });
  }

  Future<dynamic> removeTodo({
    required Database database,
    required int id,
  }) async {
    return await database.transaction((txn) async {
      await txn.rawDelete('DELETE FROM todo where id = $id');
    });
  }
}
