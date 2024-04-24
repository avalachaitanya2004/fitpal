import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fit_pal/Controllers/initializationController.dart';
import 'package:fit_pal/pages/home_page.dart';
import 'package:fit_pal/pages/pre_login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends StatefulWidget {
  const LoginController({super.key});

  @override
  State<LoginController> createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    user = _auth.currentUser;
    super.initState();
  }

  // triggerNotification() {
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: 1,
  //       channelKey: 'basic_channel',
  //       title: "Hello! ${user!.displayName} ",
  //       body: "Login Successful",
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      // triggerNotification();
      return InitializationController();
    } else {
      return PreLogin();
    }
  }
}
