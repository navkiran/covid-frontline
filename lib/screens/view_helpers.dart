import 'package:covid_frontline/screens/forms/provide/contribute_form.dart';
import 'package:covid_frontline/screens/officialscreens/viewtechreg.dart';
import 'package:covid_frontline/screens/officialscreens/viewvolunteerappl.dart';
import 'package:flutter/material.dart';
import 'package:covid_frontline/components/rounded_card.dart';
import 'package:line_icons/line_icons.dart';

class ViewHelpersScreen extends StatefulWidget {
  @override
  _ViewHelpersScreenState createState() => _ViewHelpersScreenState();
}

class _ViewHelpersScreenState extends State<ViewHelpersScreen> {
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
            title: 'NGOs and Food Banks',
            subtitle: 'View the NGOs and Food Banks in the district',
            icon: LineIcons.money,
          ),
          RoundedCard(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewVolunteerApplications()));
            },
            title: 'Applications',
            subtitle: 'Process applications for volunteers.',
            icon: Icons.verified_user,
          ),
          RoundedCard(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewTechnicalWorkerRegistrations()));
            },
            title: 'Registrations',
            subtitle: 'Process registerations for technical workers.',
            icon: Icons.verified_user,
          ),
        ],
      ),
    ));
  }
}
