import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';

// ignore: must_be_immutable
class AppGoogleMap extends StatefulWidget {
   AppGoogleMap({
    Key? key,
  }) : super(key: key);

  @override
  State<AppGoogleMap> createState() => _AppGoogleMapState();
}

class _AppGoogleMapState extends State<AppGoogleMap> {
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

 Set<Marker> _markers = Set<Marker>(); 

Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(initalCameraPosition));
  }
  final CameraPosition initalCameraPosition = CameraPosition(
    zoom: 15,
    target: LatLng(double.parse(LocalSharePreference.currentLatitude), double.parse(LocalSharePreference.currentLongitude)),
  );
static  LatLng targetLatLng = LatLng(double.parse(LocalSharePreference.currentLatitude), double.parse(LocalSharePreference.currentLongitude));

  @override
  void initState() {
    _goToTheLake();
    super.initState();

    _markers.add(
      Marker(
        markerId: MarkerId('target_marker'),
        position: targetLatLng,
        infoWindow: InfoWindow(
          title: 'Current Location',
          snippet: 'This is the current location',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: initalCameraPosition,
      markers: _markers,
      onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
    );
  }
}
