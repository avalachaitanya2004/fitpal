import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_pal/Controllers/LoginController.dart';
import 'package:fit_pal/Controllers/login_register_controller.dart';
import 'package:fit_pal/loadingPages/loadingpage1.dart';
import 'package:fit_pal/pages/Faq.dart';
import 'package:fit_pal/pages/HomePages/home.dart';
import 'package:fit_pal/pages/add_food_page.dart';
import 'package:fit_pal/pages/bottomnav.dart';
import 'package:fit_pal/pages/edit_profile.dart';
import 'package:fit_pal/pages/friend_search_page.dart';
import 'package:fit_pal/pages/getStarted.dart';
import 'package:fit_pal/pages/home_page.dart';
import 'package:fit_pal/pages/interval_page.dart';
import 'package:fit_pal/pages/introPages/intro_page_2.dart';
import 'package:fit_pal/pages/login_page.dart';
import 'package:fit_pal/pages/pre_login.dart';
import 'package:fit_pal/pages/preview_food.dart';
import 'package:fit_pal/pages/profile_page.dart';
import 'package:fit_pal/pages/register_page.dart';
import 'package:fit_pal/pages/side_menu.dart';
import 'package:fit_pal/pages/streak_calendar.dart';
import 'package:fit_pal/pages/take_photo.dart';
import 'package:fit_pal/pages/test.dart';
import 'package:fit_pal/pages/workout_start_page.dart';
import 'package:fit_pal/pages/create_playlist.dart';
import 'package:fit_pal/utility/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'dart:js_util';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // AwesomeNotifications().initialize(
  //   'resource://drawable/notification_icon',
  //   [
  //     NotificationChannel(
  //       channelGroupKey: 'basic_channel_group',
  //       channelKey: 'basic_channel',
  //       channelName: 'Basic notifications',
  //       channelDescription: 'Notification channel for basic tests',
  //       defaultColor: Color(0xFF9D50DD),
  //       ledColor: Colors.white,
  //     )
  //   ],
  //   channelGroups: [
  //     NotificationChannelGroup(
  //       channelGroupKey: 'basic_channel_group',
  //       channelGroupName: 'Basic group',
  //     )
  //   ],
  //   debug: true,
  // );
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCADqqQq4k36RJkRrk2zPYLZPNrKZxV1xc',
        appId: '1:847381653180:android:24d472fb5c23d7e00b52b9',
        messagingSenderId: '847381653180',
        projectId: 'fitpalv3',
        storageBucket: 'fitpalv3.appspot.com',
      ),
    );
    await FirebaseApi().initNotifications();
  } else {
    await Firebase.initializeApp();
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your aplication.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => RegisterLoginController(from_pre_login: false),
        '/register': (context) => RegisterLoginController(from_pre_login: true),
        '/preLogin': (context) => PreLogin(),
        '/getStarted': (context) => GetStarted(),
        '/fields': (context) => IntroPage2(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LoginController(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
