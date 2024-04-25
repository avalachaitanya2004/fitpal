import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fit_pal/Controllers/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/whiteBack.png'))),
            height: 100,
            width: 100,
          ),
          LottieBuilder.asset("assets/animations/splash.json")
        ],
      ),
      nextScreen: const LoginController(),
      splashIconSize: 700,
    );
  }
}

class SplasgScreen extends StatefulWidget {
  const SplasgScreen({super.key});

  @override
  State<SplasgScreen> createState() => _SplasgScreenState();
}

class _SplasgScreenState extends State<SplasgScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginController();
      }));
    });

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/whiteBack.png'))),
                height: 300,
                width: 300,
              ),
              Container(
                  height: 100,
                  child: Lottie.asset("assets/animations/splash6.json"))
            ],
          ),
        ),
      ),
    );
  }
}
