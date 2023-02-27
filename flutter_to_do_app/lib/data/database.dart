import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList1 = [];

  // reference our box
  final _myBox = Hive.box('myBox');

//run this method if this is the 1st time ever openinig this app
  void creatInitialData() {
    toDoList1 = [
      ['По тренироваться 🏋🏼‍♀️', false, 2, '2023.01.15', 0],
      ['По завтракать 🥗', false, 1, '2023.01.15', 2],
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
