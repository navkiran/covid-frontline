import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_frontline/components/rounded_card.dart';

final _firestore = Firestore.instance;

class ContributeScreen extends StatefulWidget {
  @override
  _ContributeScreenState createState() => _ContributeScreenState();
}

class _ContributeScreenState extends State<ContributeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('NGOs close to you'),
          backgroundColor: kFgcolor,
        ),
        backgroundColor: kBgcolor,
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('local_ngos').snapshots(),
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
              _show.add(Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                      color: kFgcolor.withOpacity(0.9),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          document.data['name'],
                          textAlign: TextAlign.center,
                          style: kOptionStyle.copyWith(color: Colors.white),
                        ),
                        Text(document.data['description'],
                            textAlign: TextAlign.center,
                            style: kOptionStyle.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.normal)),
                        Text('Donate using upi: ' + document.data['upi_id'],
                            textAlign: TextAlign.center,
                            style: kOptionStyle.copyWith(
                                color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                ),
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
