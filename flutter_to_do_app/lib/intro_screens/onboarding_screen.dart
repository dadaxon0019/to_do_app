import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/To%20Do/to_do_main_screen.dart';
import 'package:flutter_to_do_app/intro_screens/intro_page_1.dart';
import 'package:flutter_to_do_app/intro_screens/intro_page_2.dart';
import 'package:flutter_to_do_app/intro_screens/intro_page_3.dart';
import 'package:flutter_to_do_app/widgets-treee.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                      spacing: 4.0,
                      radius: 10.0,
                      dotWidth: 20.0,
                      dotHeight: 10.0,
                      paintStyle: PaintingStyle.stroke,
                      dotColor: Colors.grey,
                      activeDotColor: Color(0xffFFC33E)),
                ),
                onLastPage
                    ? Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff252525),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Route route = MaterialPageRoute(builder: (context) {
                              return WidgetTree();
                            });
                            Navigator.push(context, route);
                          },
                          icon: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff252525),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
