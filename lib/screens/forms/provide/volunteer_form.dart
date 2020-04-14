import 'package:flutter/material.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:covid_frontline/components/rounded_button.dart';
import 'package:covid_frontline/components/nks_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class VolunteerForm extends StatefulWidget {
  @override
  _VolunteerFormState createState() => _VolunteerFormState();
}

class _VolunteerFormState extends State<VolunteerForm> {
  @override
  Widget build(BuildContext context) {
    return NksForm(
        request: false,
        title: 'Volunteer',
        needText:
            'Kindly mention your age and travel history if any and wait for our call.');
  }
}
