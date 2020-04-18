import 'package:covid_frontline/components/rounded_button.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_in.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Firestore _firestore = Firestore.instance;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password, _district, _state, _role;
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
                    if (_role == 'admin' &&
                        input.contains('.gov.in') == false) {
                      return 'Use an email that has .gov.in';
                    }
                    return null;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
                  onSaved: (input) => _email = input,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  validator: (input) {
                    if (input.length < 6) {
                      return 'Longer password please. Add special characters.';
                    }
                    return null;
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
                      return 'Provide a district';
                    }
                    return null;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'District'),
                  onSaved: (input) {
                    setState(() {
                      _district = input;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Provide a state';
                    }
                    return null;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'State'),
                  onSaved: (input) {
                    setState(() {
                      _state = input;
                    });
                  },
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
                RoundedButton(
                    title: 'Sign Up',
                    onPressed: () => signUp(_role, _district, _state)),
              ],
            )),
      ),
    );
  }

  void signUp(String _role, String _district, String _state) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        _firestore.collection('users_db').document(user.uid).setData({
          "uid": user.uid,
          "name": Timestamp.fromDate(DateTime.now()),
          "role": _role,
          "district": _district,
          "state": _state,
        });
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
