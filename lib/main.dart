// @dart=2.9

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fimii/style.dart';
import 'package:fimii/ui/views/home_view.dart';

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
      title: 'Futebol',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          titleTextStyle: appBarTextStyle
        ),
        textTheme: TextTheme(
          headline1: heading1TextStyle,
          headline2: heading2TextStyle,
          headline3: heading3TextStyle,
          headline4: heading4TextStyle,
          headline5: heading5TextStyle,
          headline6: heading6TextStyle,
          subtitle1: subtitle1TextStyle,
          subtitle2: subtitle2TextStyle,
          bodyText1: bodyText1TextStyle,
          bodyText2: bodyText2TextStyle,
          caption: captionTextStyle,
          button: buttonTextStyle,
          overline: overlineTextStyle
        )
      ),
      home: AnimatedSplashScreen(
        splash: 'assets/img/logo.png',
        nextScreen: HomeView(),
      ),
    );
  }
}
