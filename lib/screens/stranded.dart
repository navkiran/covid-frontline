import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_frontline/components/rounded_button.dart';
import 'package:covid_frontline/screens/auth/user_home.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
FirebaseUser user;
String filledContact, userId;

Position currentLoc;

var strandedRequest = {
  'contact': filledContact,
  'coord': currentLoc,
  'uid': userId,
};

class StrandedHelp extends StatefulWidget {
  @override
  _StrandedHelpState createState() => _StrandedHelpState();
}

class _StrandedHelpState extends State<StrandedHelp> {
  Timer timer;
  @override
  void initState() {
    super.initState();
    getUser();

    timer = Timer.periodic(Duration(milliseconds: 300), (Timer t) {
      print('Fetching location');
      getCurrentLoc();
    });
  }

  getCurrentLoc() async {
    Position temp = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    if (temp != null)
      setState(() {
        currentLoc = temp;
      });
    else {
      print('Error fetching location');
    }
  }

  getUser() async {
    user = await _auth.currentUser();
    userId = user.uid;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgcolor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 7.0,
                      )
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'If the lockdown has left you stranded far from home and you are without food, money or shelter, press the below button to notify the local authorities of your current location.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                  decoration: kFormTextFieldDecoration.copyWith(
                      hintText: 'How can we contact you?'),
                  onChanged: (value) {
                    setState(() {
                      filledContact = value;
                    });
                  },
                ),
                RoundedButton(
                  title: 'Seek Help',
                  onPressed: () {
                    _firestore
                        .collection('stranded')
                        .document(userId)
                        .setData(strandedRequest);
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserHome()));
                  },
                ),
                Text(
                  'Yes, I am stranded. Notify local authorities.',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20.0),
                currentLoc != null
                    ? Text(
                        'Your current coordinates are: Lat ${currentLoc.latitude}  Long ${currentLoc.longitude} ',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      )
                    : Text(
                        'Your current coordinates are: 31.6340° N, 74.8723° E ',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
