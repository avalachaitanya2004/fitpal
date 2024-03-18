import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                    child: Lottie.asset(
                  'assets/animations/gettingStarted.json',
                  height: 450,
                )),
              ),
              // const SizedBox(
              //   height: 5,
              // ),
              Center(
                child: Text(
                  'Lets Get Started',
                  // textAlign: Cen,
                  style: TextStyle(
                    fontFamily: 'Bebas_Neue',
                    fontSize: 60,
                  ),
                ),
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'By collecting initial data, we tailor your app experience to match your preferences. Lets start this journey together and unlock this apps full potential, personalized just for you.',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/fields');
                },
                child: Center(
                  // child:
                  //     Lottie.asset('assets/animations/next.json', height: 100)
                  child: Icon(
                    Icons.arrow_right,
                    size: 100,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
