import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/To%20Do/dialog_box.dart';
import 'package:flutter_to_do_app/To%20Do/todo_tile.dart';
import 'package:flutter_to_do_app/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

class ToDoScreen extends StatefulWidget {
  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  //reference the hive box
  final _myBox = Hive.box('myBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //if this is 1st time ever opening the app,then create default data
    if (_myBox.get('TODOLIST') == null) {
      db.creatInitialData();
    } else {
      //the already exists data
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  //chekBoxChanged was tapped
  void chekBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList1[index][2] = !db.toDoList1[index][2];
    });
    db.upDateBase();
  }
  //save new task

  void saveNewTask() {
    setState(() {
      db.toDoList1.add([_controller1.text, _controller2.text, false]);

      _controller1.clear();
      _controller2.clear();
    });
    Navigator.of(context).pop();
    db.upDateBase();
  }

  //create createNewTask
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          mainTitle: _controller1,
          descriptionTitle: _controller2,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //clear all tasks
  void clearAllTask() {
    setState(() {
      db.toDoList1.clear();
    });
    db.upDateBase();
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList1.removeAt(index);
    });
    db.upDateBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      appBar: AppBar(
        backgroundColor: Color(0xff252525),
        title: Text('My Plans'),
        elevation: 2,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Add events',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                    iconSize: 35,
                    onPressed: createNewTask,
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                    iconSize: 35,
                    onPressed: () {
                      AlertDialog alert = AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        title: const Text('Are you sure ?'),
                        content: const Text('All Task will be delete!'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(
                              context,
                              'Cancel',
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.indigo),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              clearAllTask();
                              Navigator.pop(context, 'Cancel');
                            },
                            child: const Text(
                              'OK',
                              style: TextStyle(color: Colors.indigo),
                            ),
                          ),
                        ],
                      );
                      db.toDoList1.isNotEmpty
                          ? showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            )
                          : null;
                    },
                    icon: Icon(
                      Icons.clear_all,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            db.toDoList1.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 350,
                          height: 300,
                          child: Lottie.network(
                              'https://assets5.lottiefiles.com/packages/lf20_4bqzai4k.json'),
                        ),
                        Text(
                          "Let's get started",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: ReorderableListView.builder(
                      itemCount: db.toDoList1.length,
                      itemBuilder: (context, index) {
                        return ToDoTile(
                          key: Key('$index'),
                          taskName: db.toDoList1[index][0],
                          taskDescription: db.toDoList1[index][1],
                          taskCompleted: db.toDoList1[index][2],
                          onChanged: (value) => chekBoxChanged(value, index),
                          deleteFunction: (context) => deleteTask(index),
                        );
                      },
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final item = db.toDoList1.removeAt(oldIndex);
                          db.toDoList1.insert(newIndex, item);
                        });
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
