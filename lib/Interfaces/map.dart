import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Mapp extends StatefulWidget {
  Mapp({Key? key}) : super(key: key);

  @override
  State<Mapp> createState() => _MappState();
}

class _MappState extends State<Mapp> {
  late Marker marker;
  late GoogleMapController mapController;
  LatLng center = const LatLng(34.739847607277355, 10.75993983379422);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  getLocationPermission() async {
    var location = Location();
    try {
      location.requestPermission();
      setState(() {});
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        Fluttertoast.showToast(msg: 'Permission denied');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: TextButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("addresses")
                .add({"position": marker.position});
          },
          child: const Text("ADD ADDRESS")),
      appBar: AppBar(
        title: const Text('ADD LOCATION'),
        backgroundColor: const Color(0xffbd2005),
      ),
      body: GoogleMap(
        onLongPress: (argument) {
          setState(() {
            marker = Marker(
                markerId: const MarkerId("location"), position: argument);
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
