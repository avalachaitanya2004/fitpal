// import 'dart:js_util';

import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fit_pal/Controllers/initializationController.dart';
import 'package:fit_pal/DataBaseServices/Intialziedata.dart';
import 'package:fit_pal/DataBaseServices/useruid.dart';
import 'package:fit_pal/DataChallenges/createChallenge.dart';
import 'package:fit_pal/DataFriends/getfriends.dart';
import 'package:fit_pal/loadingPages/loadingpage1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fit_pal/DataWorkout/assignworkout.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegPage;
  const LoginPage({super.key, required this.showRegPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BuildContext? dialogContext;
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool is_loading = false;
  bool is_loading1 = false;
  UserCredential? _userCredential;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  Future signin() async {
    try {
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       print('in builder $context');
      //       // dialogContext = context;
      //       return BackdropFilter(
      //         filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      //         child: Center(
      //             child: Lottie.asset(
      //           'assets/animations/loading_balance.json',
      //           height: 200,
      //         )),
      //       );
      //     });
      setState(() {
        is_loading = true;
      });
      // print('before fnd $context');
      // dialogContext = context;
      _userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text.trim());
      // print('after fnd $context');
      // Navigator.of(dialogContext!).pop;
      setState(() {
        is_loading = false;
      });
      setState(() {
        is_loading1 = true;
      });
      Future.delayed(Duration(seconds: 1), () {
        // setState(() {
        //   is_loading1 = false;
        // });
        // Navigator.pushReplacementNamed(context, '/home');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return InitializationController();
        }));
      });
    } on FirebaseAuthException catch (e) {
      // print('closing dialog');
      // print('dialog context ${dialogContext}');
      // print('context is $context');
      // Navigator.of(context).pop;
      // Navigator.pop();
      // dialogContext?.pop();
      setState(() {
        is_loading = false;
      });
      print('Failed with error code: ${e.code}');

      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        setState(() {
          password_no_match = true;
        });
      }
    } catch (e) {
      setState(() {
        is_loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    // Navigator.of(context).pop;
    // if(UserCredential != null){}
  }

  final snackBar = SnackBar(
    content: Text('Something went wrong please try again'),
  );
  bool if_valid_email = true;
  bool email_not_entered = false;
  bool if_no_email = false;
  bool password_not_entered = false;
  bool password_no_match = false;

  String return_label_text_email() {
    String s = 'Email';
    if (if_no_email) {
      s = 'This email is not present';
      return s;
    }
    if (!if_valid_email) {
      s = 'Please enter a valid email';
      return s;
    }

    if (email_not_entered) {
      s = 'Please enter email';
      return s;
    }

    return s;
  }

  bool check_password() {
    // check whether email p=matches woith password
    return true;
  }

  bool check_allfilled() {
    if (_email.text == "") {
      // print("case-1");
      setState(() {
        email_not_entered = true;
        // if_valid_email = false;
        if_valid_email = true;
      });
      return false;
    } else {
      if (!EmailValidator.validate(_email.text)) {
        // print("case-2");
        setState(() {
          if_valid_email = false;
        });
        return false;
      } else {
        setState(() {
          email_not_entered = false;
          if_valid_email = true;
        });
      }
    }
    if (_password.text == "") {
      // print("case-3");
      setState(() {
        password_not_entered = true;
      });
      return false;
    } else {
      setState(() {
        password_not_entered = false;
      });
    }
    if (check_password()) {
      return true;
    } else {
      return false;
    }
  }

  void sign_in_done() async {
    print(check_allfilled());
    if (check_allfilled()) {
      await signin();
      if (_userCredential != null) {
        AuthService.setUID(_userCredential!.user!.uid);
        // UserData userData =
        //     UserData(uid: _userCredential!.user!.uid, statusMap: {});
        // await userData.addUsersListToDatabase(
        //     _userCredential!.user!.uid); // Await this call
        // AssignChallenge assignChallenge =
        //     AssignChallenge(uid: _userCredential!.user!.uid);
        // assignChallenge.assign('85nJuvpNP79aiMtHPN9C');
        // assignChallenge.assign('grNIf8NbMQhG3iw5ENY6');
        // InitializeWorkout initializeWorkout =
        //     InitializeWorkout(uid: _userCredential!.user!.uid);
        // initializeWorkout.addWorkout('yoga', 60);
        // initializeWorkout.addWorkout('sleep', 40);
        // Dataservices dataservices =
        //     Dataservices(uid: _userCredential!.user!.uid);
        // dataservices.StreakandWater();
        // dataservices.initializeWater(target: 12, quantity: 400);
        // await dataservices.updateWaterIntakebyOne();
        // await dataservices.updateWaterIntakebyOne();
        // await dataservices.updateWaterIntakebyOne();
        // await dataservices.updateWaterIntakebySubOne();
      }
    }
  }

  bool is_visible = false;
// this a varible for the showpassword function
  void changeVisibility() {
    setState(() {
      is_visible = !is_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !is_loading1
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //logo

                      // title\
                      const Text(
                        'FitPal',
                        style: TextStyle(
                          fontFamily: 'Bebas_Neue',
                          fontSize: 70,
                        ),
                      ),
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //email
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: _email,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              fillColor: Colors.grey[50],
                              filled: true,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                // borderSide: BorderSide(color: Colors.lightBlue, width: 4),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: (if_no_email ||
                                        email_not_entered ||
                                        !if_valid_email)
                                    ? const BorderSide(color: Colors.red)
                                    : const BorderSide(color: Colors.blue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: (if_no_email ||
                                        email_not_entered ||
                                        !if_valid_email)
                                    ? const BorderSide(color: Colors.red)
                                    : const BorderSide(color: Colors.blue),
                              ),
                              labelText: return_label_text_email(),
                              labelStyle: (if_no_email ||
                                      email_not_entered ||
                                      !if_valid_email)
                                  ? const TextStyle(
                                      color: Colors.red,
                                    )
                                  : null,
                              floatingLabelStyle: TextStyle(
                                color: (if_no_email ||
                                        email_not_entered ||
                                        !if_valid_email)
                                    ? Colors.red
                                    : Colors.blue,
                              )

                              // hintText: 'Username',
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: _password,
                          obscureText: !is_visible,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[50],
                              filled: true,
                              isDense: true,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                  onTap: changeVisibility,
                                  child: Icon(is_visible
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.lightBlue),
                              ),
                              labelText: 'Password',
                              errorText: password_not_entered
                                  ? 'Please enter password'
                                  : (password_no_match
                                      ? 'Either your email or password is incorrect'
                                      : null),
                              floatingLabelStyle: TextStyle(
                                color:
                                    (password_not_entered || password_no_match)
                                        ? Colors.red
                                        : Colors.blue,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      // forgot password
                      const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 18.0),
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                      //login button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: sign_in_done,
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: !is_loading
                                ? const Center(
                                    child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                    ),
                                  ))
                                : const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(left: 30, right: 10),
                            child: const Divider(),
                          )),
                          const Text("or sign in with"),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 30),
                            child: const Divider(),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //google or apple
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // padding: EdgeInsets.all(20),
                            // decoration: BoxDecoration(
                            //   border: Border.all(),
                            // ),
                            child: Image.asset(
                              'assets/images/Google.png',
                              height: 40,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Container(
                            // decoration: BoxDecoration(
                            //   border: Border.all(),
                            // ),
                            child: Image.asset(
                              'assets/images/Apple.png',
                              height: 45,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      // no account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Dont have an account yet?"),
                          SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: widget.showRegPage,
                            child: Container(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : const LoadingScreen1();
  }
}
