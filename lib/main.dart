import 'package:covid_frontline/screens/auth/mainstart.dart';
import 'package:covid_frontline/screens/auth/user_home.dart';
import 'package:covid_frontline/screens/can_help_screen.dart';
import 'package:covid_frontline/screens/need_help_screen.dart';
import 'package:covid_frontline/screens/welcome_screen.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: kBgcolor,
          accentColor: kFgcolor,
          fontFamily: kfont1,
          primaryColorBrightness: Brightness.dark),
      home: MainStartScreen(),
    );
  }
}
