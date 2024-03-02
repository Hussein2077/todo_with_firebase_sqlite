import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_firebase/core/utils/app_size.dart';
import 'package:todo_with_firebase/features/home/data/task_model.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/get_tasks_bloc/get_tasks_bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/get_tasks_bloc/get_tasks_event.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/get_tasks_bloc/get_tasks_state.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/local%20blocs/database.bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/local%20blocs/database.state.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/local%20blocs/todo.bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/local%20blocs/todo.state.dart';
import 'package:todo_with_firebase/features/home/presentation/widgets/add_task_dialog.dart';
import 'package:todo_with_firebase/features/home/presentation/widgets/auth_button.dart';
import 'package:todo_with_firebase/features/home/presentation/widgets/home_tab_bar.dart';
import 'package:todo_with_firebase/features/home/presentation/widgets/success_tab_bar.dart';
import 'package:todo_with_firebase/features/home/presentation/widgets/tasks_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;
  int isFirst = 0;
  List<TaskModel> tempData = [];
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  TodoBloc? _todoBloc;

  List<TaskModel> combineLists(List<TaskModel> list1, List<TaskModel> list2) {
    Set<TaskModel> uniqueItems = Set<TaskModel>.from(list1);
    uniqueItems.addAll(list2);

    return uniqueItems.toList();
  }

  @override
  void initState() {
    BlocProvider.of<TaskBloc>(context).add(LoadTasksEvent());
    tabController = TabController(length: 3, vsync: this);
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return  BlocProvider<TodoBloc>(
      create: (context) => _todoBloc!..getTodos(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.defaultSize! * 2.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppSize.defaultSize! * 3,
                ),
                Padding(
                  padding: EdgeInsets.only(left: AppSize.defaultSize! * 2),
                  child: Text(
                    'Good Morning',
                    style: TextStyle(
                        fontSize: AppSize.defaultSize! * 3,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: AppSize.defaultSize!,
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 3.5,
                  width: AppSize.screenWidth! * .7,
                  child: HomeTabBar(
                    tabController: tabController,
                  ),
                ),
                BlocConsumer<DatabaseBloc, DatabaseState>(
                  listener: (context, state) {
                    if (state is LoadDatabaseState) {
                      _todoBloc = TodoBloc(
                          database: context.read<DatabaseBloc>().database!);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadDatabaseState) {
                      return _connectionStatus != ConnectivityResult.none
                          ? BlocBuilder<TaskBloc, TaskState>(
                              builder: (context, state) {
                                if (state is LoadingTasksState) {
                                  log('LoadingTasksState');
                                  if (isFirst == 0) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return SuccessTabBarView(
                                      tasks: tempData,
                                      controller: tabController,
                                    );
                                  }
                                } else if (state is LoadedTasksState) {
                                  if (_connectionStatus !=
                                      ConnectivityResult.none) {
                                    combineLists(state.tasks, _todoBloc!.todos);
                                  }
                                  isFirst++;
                                  tempData = state.tasks;
                                  log('LoadedTasksState');
                                  return SuccessTabBarView(
                                    tasks: combineLists(
                                        state.tasks, _todoBloc!.todos),
                                    controller: tabController,
                                  );
                                } else if (state is ErrorState) {
                                  log('ErrorState');
                                  return const Text('Error');
                                } else {
                                  log('notttttttttttttState');
                                  return const SizedBox();
                                }
                              },
                            )
                          :  BlocConsumer<TodoBloc, TodoState>(
                              listener: (context, todoState) {},
                              builder: (context, todoState) {
                                if (todoState is InitTodoState) {
                                  log('InitTodoState');

                                  return SuccessTabBarView(
                                    tasks:
                                        combineLists(tempData, _todoBloc!.todos),
                                    controller: tabController,
                                  );
                                }
                                log('SizedBox');
                                return const SizedBox();
                              },
                            );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const Spacer(),
                MainButton(
                  widget: const Text('Create Task'),
                  color: Colors.green,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: SizedBox(
                            height: AppSize.screenHeight! * .3,
                            width: AppSize.screenWidth,
                            child: AddTaskDialog(
                              todoBloc: _todoBloc,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: AppSize.defaultSize!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
