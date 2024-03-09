// import 'package:fit_pal/Controllers/check_login.dart';
import 'package:fit_pal/Controllers/login_register_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

// import 'dart:js_util';

class PreLogin extends StatelessWidget {
  const PreLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        // animated image
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Center(
              child:
                  Lottie.asset('assets/animations/pre_login_meditating.json')),
        ),
        const SizedBox(height: 10),
        // some text
        const Text(
          'FitPal',
          style: TextStyle(
            fontFamily: 'Bebas_Neue',
            fontSize: 80,
          ),
        ),
        // const SizedBox(height: 5),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Empowering Your Fitness Journey, Every Step of the Way.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
            ),
          ),
        ),

        // login ot signup
        const SizedBox(height: 80),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Sign in
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RegisterLoginController(from_pre_login: true)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.lightBlue,
                  ),
                  height: 60,
                  width: 150,
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              //Register
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RegisterLoginController(from_pre_login: false)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.blue),
                  ),
                  height: 60,
                  width: 150,
                  child: const Center(
                    child: Text('Register',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
