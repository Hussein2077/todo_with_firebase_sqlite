import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String taskName;
  final String? id;
  final String dueDate;
  final int isDone;

  TaskModel({
    required this.taskName,
    required this.dueDate,
    this.id,
    required this.isDone,
  });

  // Convert the TaskModel to a map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'dueDate': dueDate,
      'isDone': isDone,
    };
  }

  @override
  List<Object?> get props => [id, taskName, dueDate, isDone];

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      taskName: map['taskName'],
      dueDate: map['dueDate'],
      isDone: map['isDone'],
    );
  }
}
