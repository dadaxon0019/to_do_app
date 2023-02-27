import 'dart:math';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTable extends StatefulWidget {
  CalendarTable({super.key, this.exampleDate = ''});
  String exampleDate;
  @override
  State<CalendarTable> createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   exampleDate,
        //   style: TextStyle(fontSize: 50, color: Colors.white),
        // ),
      ],
    );
  }
}
