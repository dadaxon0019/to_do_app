import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/To%20Do/to_do_main_screen.dart';
import 'Screens/chart_screen.dart';
import 'Screens/setting_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  int _selectedIndex = 0;

  void _navigationBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    ToDoScreen(),
    ChartScreen(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Color.fromARGB(174, 158, 158, 158),
          currentIndex: _selectedIndex,
          onTap: _navigationBar,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xff252525),
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: ImageIcon(
                  AssetImage('assets/icons/to-do-list.png'),
                  size: 30,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: ImageIcon(
                  AssetImage('assets/icons/bar-chart.png'),
                  size: 30,
                ),
              ),
              label: 'Chart',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: ImageIcon(
                  AssetImage('assets/icons/gear.png'),
                  size: 30,
                ),
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
