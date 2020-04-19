import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
FirebaseUser user;

class ContributeScreen extends StatefulWidget {
  @override
  _ContributeScreenState createState() => _ContributeScreenState();
}

class _ContributeScreenState extends State<ContributeScreen> {
  String userDistrict, userState;
  getUser() async {
    user = await _auth.currentUser();
    var doc = await _firestore.collection('users_db').document(user.uid).get();
    userDistrict = doc.data['district'];
    userState = doc.data['state'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('NGOs in your state'),
          backgroundColor: kFgcolor,
        ),
        backgroundColor: kBgcolor,
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('local_ngos')
              .where('state', isEqualTo: userState)
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
              print(document.data['upi_id']);
              _show.add(InfoTile(
                name: document.data['name'],
                state: document.data['state'],
                description: document.data['description'],
                upiId: document.data['upi_id'],
              ));
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return _show[index];
              },
              itemCount: _show.length,
            );
          },
        ),
      ),
    );
  }
}

class InfoTile extends StatefulWidget {
  final String name, state, description, upiId;

  InfoTile({this.name, this.description, this.upiId, this.state});
  @override
  _InfoTileState createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 10.0,
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        title: Text(widget.name),
        subtitle: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(widget.description)),
              SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.upiId + ' (Donate directly via upi)'),
                  Text(widget.state),
                ],
              ),
            ],
          ),
        ),
        leading: Icon(
          Icons.info,
          size: 50,
        ),
      ),
    );
  }
}
