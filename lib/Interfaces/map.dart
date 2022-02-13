import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapp extends StatefulWidget {
  const Mapp({Key? key}) : super(key: key);

  @override
  State<Mapp> createState() => _MappState();
}

class _MappState extends State<Mapp> {
  late GoogleMapController mapController;
  LatLng center = const LatLng(19.018255973653343, 72.84793849278007);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD LOCATION'),
        backgroundColor: const Color(0xffbd2005),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: center,
            zoom: 11.0, tilt: 0, bearing: 0
        ),
        myLocationEnabled: true,
      ),
    );
  }
}
