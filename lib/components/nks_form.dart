import 'package:flutter/material.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:covid_frontline/components/rounded_button.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class NksForm extends StatefulWidget {
  final bool request;
  final String title;
  final String needText;
  final List<Widget> extrafields;
  NksForm({this.request = true, this.title, this.extrafields, this.needText});
  @override
  _NksFormState createState() => _NksFormState();
}

class _NksFormState extends State<NksForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
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
                    widget.request
                        ? 'Claims made in requests may be verified, post only genuine requests.'
                        : 'You will be first vetted by local government prior to approval.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                widget.extrafields != null
                    ? Column(children: widget.extrafields)
                    : SizedBox(),
                Column(
                  children: <Widget>[
                    widget.needText != null
                        ? TextField(
                            keyboardType: TextInputType.multiline,
                            minLines: 5,
                            maxLines: null,
                            textAlign: TextAlign.center,
                            onChanged: (value) {},
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: widget.needText, hintMaxLines: 4),
                          )
                        : SizedBox(),
                    SizedBox(height: 10.0),
                    TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {},
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter name of recipient'),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      onChanged: (value) {},
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Contact'),
                    ),
                    StateDropDown(),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: null,
                      textAlign: TextAlign.center,
                      onChanged: (value) {},
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Street Address'),
                    ),
                  ],
                ),
                RoundedButton(
                  onPressed: () {
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
  String _region, _subregion, sname;
  @override
  void initState() {
    super.initState();
    _region = '';

    _subregion = '';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
        });
  }
}
