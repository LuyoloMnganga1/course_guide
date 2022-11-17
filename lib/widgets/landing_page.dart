import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:course_guide/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSplashScreen(
        backgroundColor: Colors.black,
        splash: Column(
          children: const [
            SizedBox(height: 100,),
            CircleAvatar(
              backgroundImage: AssetImage("img/logo.png"),
            ),
            Text('Course Guide',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),)
          ],
        ),
        nextScreen: const HomePage(),
        splashIconSize: 400,
        duration: 4000,
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        animationDuration: const Duration(seconds: 4),

      ),
    );
  }
}
