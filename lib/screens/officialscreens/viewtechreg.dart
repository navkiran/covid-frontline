import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
FirebaseUser user;

class ViewTechnicalWorkerRegistrations extends StatefulWidget {
  @override
  _ViewTechnicalWorkerRegistrationsState createState() =>
      _ViewTechnicalWorkerRegistrationsState();
}

class _ViewTechnicalWorkerRegistrationsState
    extends State<ViewTechnicalWorkerRegistrations> {
  String userDistrict, userState;
  getUser() async {
    user = await _auth.currentUser();
    var doc = await _firestore.collection('users_db').document(user.uid).get();
    userDistrict = doc.data['district'];
    userState = doc.data['state'];
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: kFgcolor,
        title: Text('Viewing Applications'),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('technical_service_registrations')
              .where("district", isEqualTo: userDistrict)
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
              if (document.data['state'] == userState)
                _show.add(InfoTile(
                  name: document.data['name'],
                  information: document.data['information'],
                  contact: document.data['contact'],
                  address: document.data['address'],
                  district: document.data['district'],
                  state: document.data['state'],
                  category: document.data['category'],
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
    ));
  }
}

class InfoTile extends StatefulWidget {
  final String name, contact, state, district, address, information, category;

  InfoTile(
      {this.name,
      this.information,
      this.category,
      this.contact,
      this.address,
      this.district,
      this.state});
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Category: ' + widget.category,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 10.0),
                      Text(widget.information),
                    ],
                  )),
              SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.contact + ' (Contact)'),
                  Text(widget.address),
                  Text(widget.district),
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
