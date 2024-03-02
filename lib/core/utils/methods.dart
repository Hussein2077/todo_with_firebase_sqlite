import 'package:todo_with_firebase/core/resource_manager/string_manager.dart';

class Methods {
//singleton class
  Methods._internal();

  static final   instance =   Methods._internal() ;

  factory  Methods() => instance ;


}