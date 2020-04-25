import 'package:covid_frontline/screens/forms/need/medicine_form.dart';
import 'package:flutter/material.dart';
import 'package:covid_frontline/components/rounded_card.dart';
import 'package:line_icons/line_icons.dart';
import 'package:covid_frontline/screens/forms/need/ration_form.dart';
import 'package:covid_frontline/screens/forms/need/technical_form.dart';

class NeedHelpScreen extends StatelessWidget {
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
                  MaterialPageRoute(builder: (context) => RationForm()));
            },
            title: 'Request Food',
            subtitle: 'I or someone near me needs food/rations.',
            icon: LineIcons.opencart,
          ),
          RoundedCard(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MedicineForm()));
            },
            title: 'Request Medicines',
            subtitle:
                'I or someone near me needs medicines on an urgent basis.',
            icon: LineIcons.medkit,
          ),
          RoundedCard(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TechnicalRequestForm()));
            },
            title: 'Technical Services',
            subtitle:
                'I or someone near me needs a service like electrician, plumbing, etc.',
            icon: Icons.people,
          )
        ],
      ),
    ));
  }
}
