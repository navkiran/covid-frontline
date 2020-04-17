import 'package:covid_frontline/screens/application_screen.dart';
import 'package:covid_frontline/screens/forms/provide/contribute_form.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_frontline/components/rounded_card.dart';
import 'package:line_icons/line_icons.dart';

final _firestore = Firestore.instance;

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ApplicationScreen()));
            },
            title: 'Applications',
            subtitle:
                'Process applications for volunteers and technical workers.',
            icon: Icons.verified_user,
          ),
        ],
      ),
    ));
  }
}
