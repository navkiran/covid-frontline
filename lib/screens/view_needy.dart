import 'package:covid_frontline/components/rounded_card.dart';
import 'package:covid_frontline/screens/officialscreens/viewneedymedicine.dart';
import 'package:covid_frontline/screens/officialscreens/viewneedyration.dart';
import 'package:covid_frontline/screens/officialscreens/viewneedytech.dart';
import 'package:covid_frontline/screens/stranded_map.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ViewNeedyScreen extends StatefulWidget {
  @override
  _ViewNeedyScreenState createState() => _ViewNeedyScreenState();
}

class _ViewNeedyScreenState extends State<ViewNeedyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundedCard(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewNeedRations()));
              },
              title: 'Rations',
              subtitle: 'Process requests for rations',
              icon: LineIcons.money,
            ),
            RoundedCard(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewNeedMedicines()));
              },
              title: 'Medicines',
              subtitle: 'Process requests for medicines.',
              icon: LineIcons.medkit,
            ),
            RoundedCard(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewNeedTechnicalService()));
              },
              title: 'Need Technical Service',
              subtitle: 'Process requests for technical workers.',
              icon: Icons.verified_user,
            ),
            RoundedCard(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StrandedMap()));
              },
              title: 'Track Stranded People',
              subtitle:
                  'See people in your area who are without shelter and far from home.',
              icon: LineIcons.location_arrow,
            ),
          ],
        ),
      ),
    ));
  }
}
