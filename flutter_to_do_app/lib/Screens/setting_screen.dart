import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/widget/dynamic_event.dart';
import 'package:lottie/lottie.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      appBar: AppBar(
        backgroundColor: Color(0xff252525),
        title: Text('Settings'),
        elevation: 2,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Lottie.asset('assets/img/15003-lottie-coming-soon.json'),
        ),
      ),
    );
  }
}
