import 'package:covid_frontline/components/rounded_button.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_in.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Firestore _firestore = Firestore.instance;
String _role;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password, _district;
  final _roles = [
    {'display': 'Admin', 'value': 'admin'},
    {'display': 'User', 'value': 'value'}
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: kBgcolor,
      appBar: new AppBar(
        backgroundColor: kFgcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Provide an email';
                    }
                    // if (input.contains('@gov.in') == false) {
                    //   return 'This is for authorized government employees only';
                    // }
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
                  onSaved: (input) => _email = input,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  validator: (input) {
                    if (input.length < 6) {
                      return 'Longer password please';
                    }
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Password'),
                  onSaved: (input) => _password = input,
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Provide a state';
                    }
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'District'),
                  onSaved: (input) => _district = input,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(hintText: 'State'),
                  onSaved: null,
                ),
                SizedBox(height: 10.0),
                DropDownFormField(
                  errorText: 'Please fill',
                  textField: 'display',
                  valueField: 'value',
                  titleText: 'Role',
                  value: _role,
                  onSaved: (value) {
                    setState(() {
                      _role = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _role = value;
                    });
                  },
                  dataSource: _roles,
                ),
                RoundedButton(title: 'Sign Up', onPressed: signUp),
              ],
            )),
      ),
    );
  }

  void signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        _firestore.collection('users_db').document(user.uid).setData({
          "uid": user.uid,
          "name": "nks",
          "role": _role == null ? 'admin' : 'user',
          "district": _district,
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
