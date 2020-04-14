import 'package:covid_frontline/screens/forms/provide/contribute_form.dart';
import 'package:covid_frontline/screens/forms/provide/volunteer_form.dart';
import 'package:flutter/material.dart';
import 'package:covid_frontline/components/rounded_card.dart';
import 'package:line_icons/line_icons.dart';

import 'forms/provide/register_tech.dart';

class CanHelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RoundedCard(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContributeScreen()));
            },
            title: 'Contribute',
            subtitle: 'I want to provide food, PPEs, money,etc.',
            icon: LineIcons.money,
          ),
          RoundedCard(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VolunteerForm()));
            },
            title: 'Volunteer',
            subtitle: 'I want to help with door-to-door delivery.',
            icon: Icons.person,
          ),
          RoundedCard(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegTechnicalForm()));
            },
            title: 'Technical Worker',
            subtitle: 'I want to register as an electrician, plumber, etc.',
            icon: Icons.verified_user,
          ),
        ],
      ),
    ));
  }
}
