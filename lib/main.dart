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
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    WelcomeScreen(),
    NeedHelpScreen(),
    CanHelpScreen(),
  ];

  static List<GButton> _buttons = [
    GButton(
      icon: LineIcons.home,
      text: 'Home',
      iconColor: Colors.white,
    ),
    GButton(
      icon: LineIcons.heart_o,
      text: 'Need Help',
      iconColor: Colors.white,
    ),
    GButton(
      icon: LineIcons.hand_stop_o,
      text: 'Can Help',
      iconColor: Colors.white,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgcolor,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: kFgcolor, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: GNav(
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 800),
            tabBackgroundColor: Colors.white,
            tabs: _buttons,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        )),
      ),
    );
  }
}
