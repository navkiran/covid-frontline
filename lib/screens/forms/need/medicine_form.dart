import 'package:flutter/material.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:covid_frontline/components/rounded_button.dart';
import 'package:covid_frontline/components/nks_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class MedicineForm extends StatefulWidget {
  @override
  _MedicineFormState createState() => _MedicineFormState();
}

class _MedicineFormState extends State<MedicineForm> {
  @override
  Widget build(BuildContext context) {
    return NksForm(
        title: 'Medicine Form',
        needText:
            'Only ask for medicines for which you have medical prescription.');
  }
}
