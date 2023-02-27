import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';

import '../Screens/chart_screen.dart';

class ToDoTile extends StatelessWidget {
  final int taskNumber;
  final String taskName;
  final bool taskCompleted;
  final int taskLevel;
  final String taskTime;
  final int taskIcon;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile(
      {Key? key,
      required this.taskNumber,
      required this.taskName,
      required this.taskTime,
      required this.taskIcon,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction,
      required this.taskLevel})
      : super(key: key);
  List<Color> colorCont = [
    Color.fromARGB(255, 138, 228, 141),
    Color.fromARGB(255, 243, 198, 130),
    Color.fromARGB(255, 202, 126, 120)
  ];
  List<Image> _iconList = [
    Image(
      image: AssetImage('assets/icons/fitness.png'),
      fit: BoxFit.cover,
      width: 40,
    ),
    Image(
      image: AssetImage('assets/icons/univer.png'),
      fit: BoxFit.cover,
      width: 40,
    ),
    Image(
      image: AssetImage('assets/icons/programing.png'),
      fit: BoxFit.cover,
      color: Colors.blue,
      width: 40,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff252525),
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Slidable(
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: deleteFunction,
                  icon: Icons.delete,
                  label: 'Delete',
                  backgroundColor: Color.fromARGB(255, 176, 17, 17),
                ),
                SlidableAction(
                  onPressed: ((context) {}),
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  icon: Icons.create,
                  label: 'Change',
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(
                left: 15,
              ),
              decoration: BoxDecoration(
                color: taskCompleted ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    _iconList[taskIcon],
                    // Text(
                    //   taskCompleted ? ' ✅ ' : ' 🎯 ',
                    //   style:
                    //       TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    // ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 230,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Задача №$taskNumber',
                            style: TextStyle(
                              fontSize: 14,
                              decoration: taskCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            taskName,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              decoration: taskCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          Text(
                            taskTime,
                            style: TextStyle(
                              fontSize: 15,
                              decoration: taskCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      value: taskCompleted,
                      shape: CircleBorder(),
                      onChanged: onChanged,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> snack(BuildContext context) {
  return AnimatedSnackBar(
    duration: Duration(seconds: 5),
    mobileSnackBarPosition: MobileSnackBarPosition.top,
    builder: ((context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xff42494B),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Container(
            width: 45,
            height: 45,
            child: Lottie.asset('assets/img/success.json'),
          ),
          Text(
            'Вы молодец !',
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 0.7,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Все задачи выполнены',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 0.7,
              color: Colors.white,
            ),
          ),
        ]),
      );
    }),
  ).show(context);
}
