import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:screenshot/screenshot.dart';

class DirectionMapScreen extends StatefulWidget {
  @override
  _DirectionMapScreenState createState() => _DirectionMapScreenState();
}

class _DirectionMapScreenState extends State<DirectionMapScreen> {
  late GoogleMapController mapController;
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? _imageFile; // Make it nullable
  String? _base64Image;

  final LatLng _startPoint = LatLng(23.7323, 90.4145); // Paltan Bus Stop
  final LatLng _endPoint = LatLng(23.7285, 90.4106); // Shapla Chattar

  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setPolyline();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _setPolyline() async {
    // Add markers
    _markers.add(Marker(
      markerId: MarkerId('start'),
      position: _startPoint,
      infoWindow: InfoWindow(title: 'Paltan Bus Stop'),
    ));

    _markers.add(Marker(
      markerId: MarkerId('end'),
      position: _endPoint,
      infoWindow: InfoWindow(title: 'Shapla Chattar'),
    ));

    // Create polyline (straight line for now)
    _polylines.add(Polyline(
      polylineId: PolylineId('route'),
      points: [_startPoint, _endPoint],
      color: Colors.blue,
      width: 5,
    ));

    setState(() {});
  }

  void _captureScreenshot() async {
    final image = await mapController.takeSnapshot();
    if (image != null) {
      setState(() {
        _imageFile = image;
        _base64Image = base64Encode(image);
      });

      print("Screenshot captured...: ${_base64Image})");

      // Optional: calculate distance
      double distanceInMeters = Geolocator.distanceBetween(
        _startPoint.latitude,
        _startPoint.longitude,
        _endPoint.latitude,
        _endPoint.longitude,
      );

      print(
          "Distance from startPoint to endPoint...: ${(distanceInMeters / 1000).toStringAsFixed(2)} km");
    } else {
      print("Failed to capture screenshot.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Map Screenshot')),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                _onMapCreated(controller);
                Future.delayed(Duration(seconds: 2),
                    _captureScreenshot); // wait to render fully
              },
              initialCameraPosition: CameraPosition(
                target: _startPoint,
                zoom: 15.0,
              ),
              polylines: _polylines,
              markers: _markers,
            ),
          ),
          if (_imageFile != null) Image.memory(_imageFile!),
        ],
      ),
    );
  }
}
