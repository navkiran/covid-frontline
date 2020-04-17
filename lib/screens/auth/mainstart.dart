import 'package:covid_frontline/components/nks_navbar.dart';
import 'package:covid_frontline/components/rounded_button.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:line_icons/line_icons.dart';
import 'sign_in.dart';
import 'sign_up.dart';
import 'package:flutter/material.dart';

class MainStartScreen extends StatefulWidget {
  @override
  _MainStartScreenState createState() => _MainStartScreenState();
}

class _MainStartScreenState extends State<MainStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgcolor,
      appBar: AppBar(
        backgroundColor: kFgcolor,
        title: Text(kAppName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CircleAvatar(
              child: Icon(
                LineIcons.shield,
                size: 70.0,
                color: kBgcolor,
              ),
              backgroundColor: kFgcolor,
              radius: 70.0,
            ),
            SizedBox(height: 10),
            RoundedButton(title: 'Sign In', onPressed: navigateToSignIn),
            RoundedButton(title: 'Sign Up', onPressed: navigateToSignUp),
          ],
        ),
      ),
    );
  }

  void navigateToSignIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  void navigateToSignUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpPage(), fullscreenDialog: true));
  }
}
