import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_firebase/core/utils/app_size.dart';
import 'package:todo_with_firebase/features/home/data/task_model.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/get_tasks_bloc/get_tasks_bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/get_tasks_bloc/get_tasks_event.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/local%20blocs/todo.bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/local%20blocs/todo.state.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/tasks_bloc/add_task_bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/tasks_bloc/add_task_events.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/tasks_bloc/add_task_states.dart';
import 'package:todo_with_firebase/features/home/presentation/widgets/auth_button.dart';
import 'package:todo_with_firebase/features/home/presentation/widgets/custom_text_field.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key, this.todoBloc});

  final TodoBloc? todoBloc;

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late TextEditingController taskName;
  late TextEditingController dueDate;

  @override
  void initState() {
    taskName = TextEditingController();
    dueDate = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskBloc, AddTaskState>(
      listener: (context, state) {
        if (state is AddTaskLoadingState) {} else
        if (state is AddTaskSuccessMessageState) {
          BlocProvider.of<TaskBloc>(context).add(LoadTasksEvent());

        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.defaultSize!),
          // Adjust the border radius as needed
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(
                  0, -3), // Changes the shadow direction and position
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.defaultSize! * 2.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create a new task',
                    style: TextStyle(
                        fontSize: AppSize.defaultSize! * 1.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.red,
                      ))
                ],
              ),
              CustomTextField(
                hintText: 'Task title',
                controller: taskName,
              ),
              CustomTextField(
                hintText: 'Due date',
                controller: dueDate,
              ),
              MainButton(
                widget: const Text('Create Task'),
                color: Colors.green,
                onTap: () {
                  if (dueDate.text != '' && taskName.text != '') {
                    BlocProvider.of<AddTaskBloc>(context).add(AddTaskEvent(
                      taskName: taskName.text,
                      dueDate: dueDate.text,
                    ));
                    if (widget.todoBloc != null) {
                      widget.todoBloc!.addTodos(TaskModel(
                        taskName: taskName.text,
                        dueDate: dueDate.text,
                        isDone: 0,
                      ));
                      Navigator.pop(context);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
