import 'package:flutter/material.dart';
import 'package:todo_with_firebase/features/home/presentation/controller/local%20blocs/todo.bloc.dart';
import 'package:todo_with_firebase/features/home/presentation/home_screen.dart';

class Routes {
  static const String home = "/home";


}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.home:
        return MaterialPageRoute(builder: (_) =>   const HomeScreen());

    }
    return unDefinedRoute();

  }
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => const SizedBox());
  }
}