import 'package:covid_frontline/screens/can_help_screen.dart';
import 'package:covid_frontline/screens/need_help_screen.dart';
import 'package:covid_frontline/screens/officia.dart';
import 'package:covid_frontline/screens/view_helpers.dart';
import 'package:covid_frontline/screens/view_needy.dart';
import 'package:covid_frontline/screens/welcome_screen.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class OfficialsHome extends StatefulWidget {
  @override
  _OfficialsHomeState createState() => _OfficialsHomeState();
}

class _OfficialsHomeState extends State<OfficialsHome> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    OfficialWelcomeScreen(),
    ViewNeedyScreen(),
    ViewHelpersScreen(),
  ];

  static List<GButton> _buttons = [
    GButton(
      icon: LineIcons.home,
      text: 'Home',
      iconColor: Colors.white,
    ),
    GButton(
      icon: LineIcons.heart_o,
      text: 'View Needy',
      iconColor: Colors.white,
    ),
    GButton(
      icon: LineIcons.hand_stop_o,
      text: 'View Helpers',
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
