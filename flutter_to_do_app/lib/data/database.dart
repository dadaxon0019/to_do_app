import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList1 = [];

  // reference our box
  final _myBox = Hive.box('myBox');

//run this method if this is the 1st time ever openinig this app
  void creatInitialData() {
    toDoList1 = [
      [
        'Задача №1',
        'По тренироваться 🏋🏼‍♀️',
        false,
      ],
      [
        'Задача №2',
        'По завтракать 🥗',
        false,
      ],
    ];
  }

  //load Data from database
  void loadData() {
    toDoList1 = _myBox.get('TODOLIST');
  }

  //updae the database
  void upDateBase() {
    _myBox.put('TODOLIST', toDoList1);
  }
}
