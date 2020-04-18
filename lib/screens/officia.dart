import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:flutter/material.dart';
import 'package:covid_frontline/components/nks_navbar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class OfficialWelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          NksNavBar(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: SizedBox(
              height: 150,
              child: TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 70),
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [
                    "Connecting those who want to help",
                    "...with those who need it the most.",
                    "Designed and developed by Navkiran Singh",
                  ],
                  textStyle: TextStyle(fontSize: 25.0, fontFamily: "Agne"),
                  textAlign: TextAlign.start,
                  alignment:
                      AlignmentDirectional.topStart // or Alignment.topLeft
                  ),
            ),
          ),
          Expanded(
            child: Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: kFgcolor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'You\'re now in administration section of the app',
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
