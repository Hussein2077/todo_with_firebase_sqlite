import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_firebase/core/utils/app_size.dart';
import 'package:todo_with_firebase/features/home/data/task_model.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/get_tasks_bloc/get_tasks_bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/get_tasks_bloc/get_tasks_event.dart';

class TasksListView extends StatefulWidget {
  const TasksListView({super.key, required this.taskModel});

  final List<TaskModel> taskModel;

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.screenHeight! * .5,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.taskModel.length,
          itemBuilder: (context, index) {
            return taskItem(
              taskModel: widget.taskModel[index],
            );
          }),
    );
  }

  taskItem({
    required TaskModel taskModel,
  }) {
    bool isDone=taskModel.isDone==1;
    return Padding(
      padding: EdgeInsets.all(AppSize.defaultSize!),
      child: Material(
        elevation: 10,
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.defaultSize!),
        child: Container(
          height: AppSize.defaultSize! * 8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSize.defaultSize!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(
                    0, 2), // changes the shadow direction and position
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSize.defaultSize! * 1.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      taskModel.taskName,
                      style: TextStyle(
                          fontSize: AppSize.defaultSize! * 1.5,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Due Date:${taskModel.dueDate}',
                      style: TextStyle(
                        fontSize: AppSize.defaultSize! * 1.2,
                      ),
                    ),
                  ],
                ),
                StatefulBuilder(
                  builder: (context,setState) {
                    return Checkbox(
                        value: isDone,
                        activeColor: Colors.green,
                        shape: const CircleBorder(),
                        onChanged: (v) async {
                          isDone=!isDone;

                          try {
                            await FirebaseFirestore.instance
                                .collection('tasks')
                                .doc(taskModel.id)
                                .update({
                              'isDone': isDone?1:0,
                            });
                            setState((){});
                            BlocProvider.of<TaskBloc>(context)
                                .add(LoadTasksEvent());

                          } catch (e) {
                            log('Error updating task status: $e');
                          }

                        });
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
