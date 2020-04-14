import 'package:flutter/material.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:covid_frontline/components/rounded_button.dart';
import 'package:covid_frontline/components/nks_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class RationForm extends StatefulWidget {
  @override
  _RationFormState createState() => _RationFormState();
}

class _RationFormState extends State<RationForm> {
  @override
  Widget build(BuildContext context) {
    return NksForm(title: 'Ration Form', needText: 'What is needed?');
  }
}
