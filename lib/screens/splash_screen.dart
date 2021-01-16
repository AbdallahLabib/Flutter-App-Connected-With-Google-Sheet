import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task/screens/form_screen.dart';
import 'package:task/services/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  PageController _pageController;
  AnimationController _scaleController;
  AnimationController _rippleController;

  Animation<double> _scaleAnimation;
  Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1800),
    );

    _rippleController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _rippleAnimation =
        Tween<double>(begin: 60, end: 80).animate(_rippleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _rippleController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _rippleController.forward();
            }
          });
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 30.0).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                  context,
                  PageTransition(
                    duration: Duration(milliseconds: 200),
                    child: FormScreen(),
                    type: PageTransitionType.fade,
                  ));
            }
          });
    _rippleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rippleController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  bool hide = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.black87,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: size.height * .23,
            ),
            AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (context, child) {
                return Container(
                  width: _rippleAnimation.value * 4.5,
                  height: _rippleAnimation.value * 5,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25),
                      color: KFillingColor.withOpacity(0.5),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          hide = true;
                        });
                        _scaleController.forward();
                      },
                      child: AnimatedBuilder(
                          animation: _scaleController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Container(
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: hide == false
                                      ? Image.asset('assets/task.PNG')
                                      : Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            Opacity(
              opacity: hide == false ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  'Click to start',
                  style: TextStyle(
                    color: KCcolor,
                    fontSize: 25.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
