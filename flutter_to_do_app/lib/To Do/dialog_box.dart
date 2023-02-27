import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/To%20Do/to_do_main_screen.dart';
import 'package:flutter_to_do_app/widget/dynamic_event.dart';
import 'package:table_calendar/table_calendar.dart';

class DialogBox extends StatefulWidget {
  final mainTitle;
  final taskNumb;
  final taskProgres;
  String? taskTime;
  int? taskLevel;
  int? taskIcon;

  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    Key? key,
    required this.onSave,
    required this.onCancel,
    required this.mainTitle,
    required this.taskNumb,
    required this.taskProgres,
    required this.taskTime,
    required this.taskLevel,
    required this.taskIcon,
  }) : super(key: key);

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  int? _selectedValueIndex;
  int? _iconValueIndex;
  List<String> buttonText = ["Легко", "Средне", "Сложно"];
  List<Color> colorCont = [Colors.green, Colors.orange, Colors.red.shade800];
  List _iconList = [
    AssetImage('assets/icons/fitness.png'),
    AssetImage('assets/icons/univer.png'),
    AssetImage('assets/icons/programing.png'),
  ];
  String dateTime = '';
  DateTime today = DateTime.now();

  void _onDayselected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      widget.taskTime =
          "${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year.toString()}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          TextField(
            keyboardType: TextInputType.multiline,
            minLines: 1, //Normal textInputField will be displayed
            maxLines: 3,
            controller: widget.mainTitle,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              hintText: 'Add Title Tasks',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
              height: 40,
              child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedValueIndex = index;
                          widget.taskLevel = index;
                          print(dateTime);
                        });
                      },
                      child: Container(
                        width: 117,
                        color: _selectedValueIndex == index
                            ? colorCont[index]
                            : Color(0xff252525),
                        child: Center(
                          child: Text(
                            buttonText[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  })),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            child: Stack(
                              children: [
                                Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: _iconList[index]),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: _iconValueIndex == index
                                        ? Colors.transparent
                                        : Color.fromARGB(63, 17, 17, 17),
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                _iconValueIndex = index;
                                widget.taskIcon = index;
                                print(widget.taskIcon);
                              });
                            },
                          ),
                        );
                      }),
                ],
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: TableCalendar(
              calendarFormat: CalendarFormat.week,
              rowHeight: 43,
              headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2022, 10, 16),
              lastDay: DateTime.utc(2024, 10, 16),
              onDaySelected: _onDayselected,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //save button
              TextButton(
                onPressed: widget.onCancel,
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.indigo),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (widget.mainTitle.text.isNotEmpty) {
                    return widget.onSave();
                  } else {}
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.indigo),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
