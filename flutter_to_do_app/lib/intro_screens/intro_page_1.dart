import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFCFC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 189,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Lottie.asset('assets/img/117420-checklist-in-green.json'),
          ),
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              textAlign: TextAlign.left,
              text: const TextSpan(
                text: 'Explore the\nworld easily',
                style: TextStyle(
                  color: Color(0xff252525),
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '\nTo your desire',
                    style: TextStyle(
                      color: Color(0xff252525),
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
