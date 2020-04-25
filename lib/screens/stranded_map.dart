import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_frontline/ui/nks_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
FirebaseUser user;

class StrandedMap extends StatefulWidget {
  @override
  _StrandedMapState createState() => _StrandedMapState();
}

class _StrandedMapState extends State<StrandedMap> {
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

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {
    Marker(
      markerId: MarkerId(DateTime.now().toString()),
      position: const LatLng(31.6398, 74.7869),
    )
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Viewing Stranded'),
          backgroundColor: kFgcolor,
        ),
        body: StreamBuilder(
            stream: _firestore.collection('stranded').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                );
              }
              final documents = snapshot.data.documents;

              for (var document in documents) {
                print(document.data['coord'].latitude);
                GeoPoint pos = document.data['coord'];
                var point = LatLng(pos.latitude, pos.longitude);
                // _addMarker(point: point, type: 0);
              }
              return GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: const LatLng(31.6398, 74.7869),
                  zoom: 11.4746,
                ),
                myLocationEnabled: true,
                compassEnabled: true,
                markers: _markers,
              );
            }),
      ),
    );
  }

  void _addMarker({LatLng point, int type = 0}) {
    _markers.add(
      Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'Stranded Person',
          snippet: '${DateTime.now()}',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          type == 0 ? BitmapDescriptor.hueRed : BitmapDescriptor.hueOrange,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller.complete(controller);
    });
  }
}
