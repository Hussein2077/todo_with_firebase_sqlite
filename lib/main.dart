import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_with_firebase/core/resource_manager/routes.dart';
import 'package:todo_with_firebase/core/service/service_locator.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/get_tasks_bloc/get_tasks_bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/get_tasks_bloc/get_tasks_event.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/local%20blocs/database.bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/local%20blocs/todo.bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/tasks_bloc/add_task_bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_with_firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ServerLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AddTaskBloc>(),
        ),
        BlocProvider<DatabaseBloc>(create: (context) => DatabaseBloc()..initDatabase()),
        BlocProvider(
          create: (context) => getIt<TaskBloc>()..add(LoadTasksEvent()),
        ),
        // BlocProvider(
        //     create: (context) =>TodoBloc(database: context.read<DatabaseBloc>().database!)..getTodos(),
        // ),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
          useMaterial3: true,
        ),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.home,
      ),
    );
  }
}
