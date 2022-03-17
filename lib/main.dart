// @dart=2.9

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fimii/ui/views/home_view.dart';
import 'package:splashscreen/splashscreen.dart';

import 'service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FiMi Air',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: 'assets/img/mask.png',
        nextScreen: HomeView(),
      ),
    );
  }
}
