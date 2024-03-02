import 'package:flutter/material.dart';
import 'package:todo_with_firebase/core/utils/app_size.dart';
import 'package:todo_with_firebase/features/home/data/task_model.dart';
import 'package:todo_with_firebase/features/home/presentation/widgets/tasks_list_view.dart';
class SuccessTabBarView extends StatelessWidget {
  const SuccessTabBarView({super.key, required this.tasks, required this.controller});
  final List<TaskModel> tasks;
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.screenHeight! * .78,
      child: TabBarView(controller: controller, children: [
        TasksListView(taskModel: tasks,),
        TasksListView(taskModel: tasks.where((element) {
          if(element.isDone==0) {
            return true;
          }else {
            return false;
          }
        }).toList(),),
        TasksListView(taskModel: tasks.where((element) {
          if(element.isDone==1) {
            return true;
          }else {
            return false;
          }
        }).toList(),),

      ]),
    );
  }
}
