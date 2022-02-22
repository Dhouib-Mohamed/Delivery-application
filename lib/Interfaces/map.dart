import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Mapp extends StatefulWidget {
  const Mapp({Key? key}) : super(key: key);

  @override
  State<Mapp> createState() => _MappState();
}

class _MappState extends State<Mapp> {
  Set<Marker> markers = {};
  late GoogleMapController mapController;
  LatLng center = const LatLng(34.739847607277355, 10.75993983379422);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: TextButton(
        onPressed: () async {
          if (markers.isEmpty) {
            Fluttertoast.showToast(msg: 'No position Chosen');
          } else {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("addresses")
                .doc()
                .set({
              "location": GeoPoint(markers.first.position.latitude,
                  markers.first.position.longitude)
            });
            Navigator.pushNamed(context, "/address");
          }
        },
        child: const Text("ADD ADDRESS", style: TextStyle(fontSize: 20)),
      ),
      appBar: AppBar(
        title: const Text('ADD LOCATION'),
        backgroundColor: const Color(0xffbd2005),
      ),
      body: GoogleMap(
        markers: markers,
        onLongPress: (argument) {
          setState(() {
            markers.clear();
            markers.add(Marker(
                markerId: const MarkerId("location"), position: argument));
          });
        },
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        initialCameraPosition:
            CameraPosition(target: center, zoom: 11.0, tilt: 0, bearing: 0),
      ),
    );
  }
}
