import 'package:covid_frontline/components/rounded_button.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

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
                    return null;
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
                    return null;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Password'),
                  onSaved: (input) => _password = input,
                  obscureText: true,
                ),
                RoundedButton(title: 'Sign In', onPressed: signIn),
              ],
            )),
      ),
    );
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        var user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password))
            .user;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
