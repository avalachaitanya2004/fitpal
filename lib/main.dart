import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fit_pal/Controllers/check_login.dart';
import 'package:fit_pal/Controllers/login_register_controller.dart';
import 'package:fit_pal/loadingPages/loadingpage1.dart';
import 'package:fit_pal/pages/getStarted.dart';
import 'package:fit_pal/pages/home_page.dart';
import 'package:fit_pal/pages/introPages/intro_page.dart';
import 'package:fit_pal/pages/introPages/intro_page_2.dart';
import 'package:fit_pal/pages/login_page.dart';
import 'package:fit_pal/pages/pre_login.dart';
import 'package:fit_pal/pages/preview_food.dart';
import 'package:fit_pal/pages/register_page.dart';
import 'package:fit_pal/pages/side_menu.dart';
import 'package:fit_pal/pages/take_photo.dart';
import 'package:fit_pal/pages/workout_start_page.dart';
import 'package:fit_pal/pages/create_playlist.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'dart:js_util';
late List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyCADqqQq4k36RJkRrk2zPYLZPNrKZxV1xc',
              appId: '1:847381653180:android:24d472fb5c23d7e00b52b9',
              messagingSenderId: '847381653180',
              projectId: 'fitpalv3'))
      : await Firebase.initializeApp();
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
      home: CreatePlaylist(),
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
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
