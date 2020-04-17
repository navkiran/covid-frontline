import 'package:covid_frontline/components/rounded_button.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:covid_frontline/components/nks_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
FirebaseUser user;
var jobs = [
  {
    "display": "Plumbing",
    "value": "Plumbing",
  },
  {
    "display": "Electricy/Electrical Appliances",
    "value": "Electricy/Electrical Appliances",
  }
];
String filledName,
    filledContact,
    _region,
    _subregion,
    filledAddress,
    filledNeed,
    user_id,
    job;

var request = {
  'name': filledName,
  'need': filledNeed,
  'job': job,
  'uid': user_id,
  'contact': filledContact,
  'state': _region,
  'district': _subregion,
  'address': filledAddress,
};

class TechnicalForm extends StatefulWidget {
  @override
  _TechnicalFormState createState() => _TechnicalFormState();
}

class _TechnicalFormState extends State<TechnicalForm> {
  String sname;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    user = await _auth.currentUser();
    user_id = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Request for Technical Worker'),
          backgroundColor: kFgcolor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'Please ensure your request is genuine, it may be verified.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: null,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        filledNeed = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Problem details', hintMaxLines: 4),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        filledName = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter name of recipient'),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        filledContact = value;
                      },
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Contact'),
                    ),
                    StateDropDown(),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: null,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        filledAddress = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Street Address'),
                    ),
                  ],
                ),
                RoundedButton(
                  onPressed: () {
                    _firestore
                        .collection('requests')
                        .document(user.uid)
                        .setData(request);
                    Navigator.pop(context);
                  },
                  title: 'Submit',
                  color: kFgcolor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StateDropDown extends StatefulWidget {
  @override
  _StateDropDownState createState() => _StateDropDownState();
}

class _StateDropDownState extends State<StateDropDown> {
  String sname;
  @override
  void initState() {
    super.initState();
    _region = '';

    _subregion = '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        DropDownFormField(
          errorText: 'Please fill',
          textField: 'display',
          valueField: 'value',
          titleText: 'Problem Category',
          value: job,
          onSaved: (value) {
            setState(() {
              job = value;
            });
          },
          onChanged: (value) {
            setState(() {
              job = value;
            });
          },
          dataSource: jobs,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('states').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                );
              }
              final documents = snapshot.data.documents;
              var _data = [];
              for (var document in documents) {
                _data.add(document.data['sname']);
              }

              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropDownFormField(
                      errorText: 'Please fill',
                      textField: 'display',
                      valueField: 'value',
                      titleText: 'State',
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
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection("states")
                        .where("sname.value", isEqualTo: _region)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      final documents = snapshot.data.documents;
                      var _districtData = [];
                      for (var document in documents) {
                        var dist = document.data['districts'];
                        for (var d in dist) {
                          _districtData.add(d);
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DropDownFormField(
                          errorText: 'Please fill',
                          textField: 'display',
                          valueField: 'value',
                          titleText: 'District',
                          value: _subregion,
                          onSaved: (value) {
                            setState(() {
                              _subregion = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _subregion = value;
                            });
                          },
                          dataSource: _districtData,
                        ),
                      );
                    },
                  )
                ],
              );
            })
      ],
    ));
  }
}
