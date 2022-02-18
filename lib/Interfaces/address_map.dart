import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressMap extends StatefulWidget {
  const AddressMap({Key? key, required this.location}) : super(key: key);
  final GeoPoint location;

  @override
  State<AddressMap> createState() => _AddressMapState();
}

class _AddressMapState extends State<AddressMap> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOCATION'),
        backgroundColor: const Color(0xffbd2005),
      ),
      body: GoogleMap(
        markers: {
          Marker(
              markerId: const MarkerId("location"),
              position:
                  LatLng(widget.location.latitude, widget.location.longitude))
        },
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.location.latitude, widget.location.longitude),
            zoom: 20.0,
            tilt: 0,
            bearing: 0),
      ),
    );
  }
}
