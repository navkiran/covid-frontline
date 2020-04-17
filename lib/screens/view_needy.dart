import 'package:covid_frontline/components/card_generic.dart' as card_class;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
FirebaseUser user;

class ViewNeedyScreen extends StatefulWidget {
  @override
  _ViewNeedyScreenState createState() => _ViewNeedyScreenState();
}

class _ViewNeedyScreenState extends State<ViewNeedyScreen> {
  String district;
  getUser() async {
    user = await _auth.currentUser();
    var doc = await _firestore.collection('users_db').document(user.uid).get();
    district = doc.data['district'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('requests')
            .where("state", isEqualTo: 'Punjab')
            .where("district", isEqualTo: district)
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
          List<Widget> _show = [];
          for (var document in documents) {
            if (document.data['district'] == district)
              _show.add(card_class.Card(
                  filledAddress: document.data['address'],
                  filledName: document.data['name'],
                  filledContact: document.data['contact'],
                  filledNeed: document.data['need'],
                  filledJob: document.data['job'],
                  filledState: document.data['state'],
                  filledDistrict: document.data['district']));
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return _show[index];
            },
            itemCount: _show.length,
          );
        },
      ),
    );
  }
}
