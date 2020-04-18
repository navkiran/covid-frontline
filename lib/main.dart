import 'package:covid_frontline/screens/auth/mainstart.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:flutter/material.dart';

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
