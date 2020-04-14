import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:covid_frontline/components/rounded_button.dart';
import 'package:covid_frontline/components/nks_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class TechnicalForm extends StatefulWidget {
  @override
  _TechnicalFormState createState() => _TechnicalFormState();
}

class _TechnicalFormState extends State<TechnicalForm> {
  String _region, _subregion, sname;
  @override
  void initState() {
    super.initState();
    _region = '';

    _subregion = '';
  }

  var _data = [
    {
      "display": "Plumbing",
      "value": "Plumbing",
    },
    {
      "display": "Electricy/Electrical Appliances",
      "value": "Electricy/Electrical Appliances",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return NksForm(
      title: 'Request for Technical Workers',
      needText: 'What is the problem?',
      extrafields: <Widget>[
        DropDownFormField(
          errorText: 'Please fill',
          textField: 'display',
          valueField: 'value',
          titleText: 'Problem Category',
          value: _region,
          onSaved: (value) {
            setState(() {
              _region = value;
            });
          },
          onChanged: (value) {
            setState(() {
              _region = value;
            });
          },
          dataSource: _data,
        ),
      ],
    );
  }
}
