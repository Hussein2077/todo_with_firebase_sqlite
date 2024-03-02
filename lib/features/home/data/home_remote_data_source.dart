import 'dart:developer';

import 'package:todo_with_firebase/core/error/failure.dart';
import 'package:todo_with_firebase/features/home/data/task_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseRemotelyDataSource {
  Future<String> addTaskToFirebase(TaskModel task);

  Future<List<TaskModel>> getTasks();
}

class AuthRemotelyDateSource extends BaseRemotelyDataSource {
  @override
  Future<String> addTaskToFirebase(TaskModel task) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        'taskName': task.taskName,
        'dueDate': task.dueDate,
        'isDone': task.isDone,
      });
      log('ssssssssssssssssssssssssss');
      return 'Task added successfully';
    } catch (e) {
      return ('Error adding task: $e');
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    log('ssssssssssssssssssssssssss');

    try {
      final querySnapshot = await fireStore.collection('tasks').get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return TaskModel(id: doc.id, taskName: data['taskName'], dueDate
                : data['dueDate'], isDone: data['isDone']);
      }).toList();
    } catch (e) {
      throw ServerFailure();
    }
  }


}
