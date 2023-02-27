import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/database.dart';

class MyHomePage extends StatefulWidget {
  String text1;
  String text2;
  int summTask;
  int finishTask;
  MyHomePage(
      {Key? key,
      this.text1 = 'Общее кол-во задач',
      this.text2 = 'Выполнено',
      this.summTask = 15,
      this.finishTask = 5})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<GDPData> _chartData;
  late TooltipBehavior _toolTipBehavior;

  late int fTask = widget.finishTask;
  late int sTask = widget.summTask;
  late String text1 = widget.text1;
  late String text2 = widget.text2;

  @override
  void initState() {
    _chartData = getChartData();
    _toolTipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SfCircularChart(
        backgroundColor: Color(0xff252525),
        title: ChartTitle(
            text: 'Статистка выполнение задач',
            textStyle: TextStyle(color: Colors.white)),
        legend: Legend(
          isVisible: true,
          textStyle: TextStyle(color: Colors.white, fontSize: 16),
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        tooltipBehavior: _toolTipBehavior,
        series: <CircularSeries>[
          DoughnutSeries<GDPData, dynamic>(
              dataSource: _chartData,
              xValueMapper: (GDPData data, _) => data.nameTask,
              yValueMapper: (GDPData data, _) => data.tasks,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true)
        ],
      ),
    ));
  }

  List<GDPData> getChartData() {
    List<GDPData> chartData = [
      GDPData(widget.text1, sTask),
      GDPData(widget.text2, fTask),
    ];
    return chartData;
  }
}

class GDPData {
  String nameTask;

  int tasks;
  GDPData(this.nameTask, this.tasks);
}
