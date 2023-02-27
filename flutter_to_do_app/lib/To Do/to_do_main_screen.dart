import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/To%20Do/dialog_box.dart';
import 'package:flutter_to_do_app/To%20Do/todo_tile.dart';
import 'package:flutter_to_do_app/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../Screens/chart_screen.dart';

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
  int taskLevelController = 1;
  double totalFinishTask = 0;
  String taskTime = '';
  int taskIcon = 1;

  //chekBoxChanged was tapped
  void chekBoxChanged(bool? value, int index) {
    db.toDoList1[index][1] = !db.toDoList1[index][1];
    if (value == true) {
      totalFinishTask += 1 / db.toDoList1.length;
      print(totalFinishTask);
    } else {
      totalFinishTask -= 1 / db.toDoList1.length;
      print(totalFinishTask);
    }
    setState(() {});
    db.upDateBase();
  }

  //create createNewTask
  void createNewTask() {
    setState(() {
      showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            taskProgres: totalFinishTask,
            taskTime: taskTime,
            taskIcon: taskIcon,
            taskLevel: taskLevelController,
            taskNumb: db.toDoList1.length,
            mainTitle: _controller1,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        },
      );
    });
  }

  GlobalKey key = GlobalKey();
  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList1.add([
        _controller1.text,
        false,
        (key.currentWidget! as DialogBox).taskLevel,
        (key.currentWidget! as DialogBox).taskTime,
        (key.currentWidget! as DialogBox).taskIcon,
      ]);
      _controller1.clear();
    });
    Navigator.of(context).pop();
    db.upDateBase();
    print(taskIcon);
    print((key.currentWidget! as DialogBox).taskIcon);
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
        title: Text('Мои Задачи'),
        actions: [
          // CircularProgressIndicatorApp(
          //   percent: totalFinishTask.toDouble(),
          // ),
          UserImage(),
          SizedBox(
            width: 15,
          )
        ],
        elevation: 2,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Кол-во задач',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '(${db.toDoList1.length})',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                    iconSize: 35,
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0))),
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: SizedBox(
                                height: 420,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    DialogBox(
                                      key: key,
                                      taskTime: taskTime,
                                      taskIcon: taskIcon,
                                      taskProgres: totalFinishTask,
                                      taskLevel: taskLevelController,
                                      taskNumb: db.toDoList1.length,
                                      mainTitle: _controller1,
                                      onSave: saveNewTask,
                                      onCancel: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
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
                        title: const Text('Вы уверены 😧?'),
                        content: const Text('Все задачи будут удалены!'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(
                              context,
                              'Cancel',
                            ),
                            child: const Text(
                              'Отмена',
                              style: TextStyle(color: Colors.indigo),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              clearAllTask();
                              Navigator.pop(context, 'Cancel');
                            },
                            child: const Text(
                              'Ок',
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
                      Icons.delete_forever_outlined,
                      color: Colors.white,
                      size: 29,
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
                          child: Lottie.asset(
                              'assets/img/61232-web-design-lottie-animation.json'),
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
                      physics: BouncingScrollPhysics(),
                      itemCount: db.toDoList1.length,
                      itemBuilder: (context, index) {
                        return ToDoTile(
                          key: Key('$index'),
                          taskNumber: index + 1,
                          taskName: db.toDoList1[index][0],
                          taskCompleted: db.toDoList1[index][1],
                          taskLevel: db.toDoList1[index][2],
                          taskTime: db.toDoList1[index][3],
                          taskIcon: db.toDoList1[index][4],
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

// class CircularProgressIndicatorApp extends StatefulWidget {
//   double percent;
//   CircularProgressIndicatorApp({
//     required this.percent,
//   });

//   @override
//   State<StatefulWidget> createState() {
//     return CircularProgressIndicatorAppState();
//   }
// }

// class CircularProgressIndicatorAppState
//     extends State<CircularProgressIndicatorApp> {
//   @override
//   Widget build(BuildContext context) {
//     return CircularPercentIndicator(
//       radius: 18.0,
//       lineWidth: 7.0,
//       percent: widget.percent,
//       progressColor: Colors.green,
//     );
//   }
// }

class UserImage extends StatelessWidget {
  const UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        image: DecorationImage(
            image: AssetImage('assets/img/user.png'), fit: BoxFit.cover),
      ),
    );
  }
}
