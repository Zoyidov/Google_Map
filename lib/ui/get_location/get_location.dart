// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:login_screen_homework/ui/map/map_screen.dart';
import 'package:login_screen_homework/utils/icons.dart';
import 'package:lottie/lottie.dart';

class LocationAccess extends StatefulWidget {
  const LocationAccess({super.key});

  @override
  _LocationAccessState createState() => _LocationAccessState();
}

class _LocationAccessState extends State<LocationAccess> {
  LatLong? _latLong;

  Future<void> _getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData? locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    setState(() {
      _latLong = LatLong(
        latitude: locationData!.latitude!,
        longitude: locationData.longitude!,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await _getLocation();

    await Future.delayed(const Duration(seconds: 1));

    if (mounted && _latLong != null) {
      final LatLng latLng = LatLng(_latLong!.latitude, _latLong!.longitude);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MapScreen(latLong: latLng);
      }));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Lottie.asset(AppImages.till),
      ),
    );
  }
}

class LatLong {
  final double latitude;
  final double longitude;

  LatLong({required this.latitude, required this.longitude});
}
