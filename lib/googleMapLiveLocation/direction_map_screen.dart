import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
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
  File? file;

  final LatLng _startPoint = LatLng(23.7323, 90.4145); // Paltan Bus Stop
  final LatLng _endPoint = LatLng(23.7285, 90.4106); // Shapla Chattar

  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _handleLocationPermission();
    getETAByBus(_startPoint, _endPoint);
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
      final mimeType = getMimeTypeFromBytes(image);
      final base64Str = base64Encode(image);
      final base64Image = 'data:$mimeType;base64,$base64Str';

      setState(() {
        _imageFile = image;
        _base64Image = base64Image;
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

  Future<void> _handleLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permission denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permission permanently denied');
      return;
    }

    print('Location permission granted');
  }

  Future<void> getETAByBus(LatLng start, LatLng end) async {
    const String apiKey = 'AIzaSyC3NpcTc3Wdtn68VCsf7ZxswuDzlNvvt9c';

    print("Api Key: $apiKey");
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
      '?origin=${start.latitude},${start.longitude}'
      '&destination=${end.latitude},${end.longitude}'
      '&mode=transit'
      '&transit_mode=bus'
      '&key=$apiKey',
    );
    print("Google Map Url...: $url");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final duration = data['routes'][0]['legs'][0]['duration']['text'];
          print("ETA by Bus: $duration");
        } else {
          print("No routes found.");
        }
      } else {
        print("Failed to get directions: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching ETA by bus: $e");
    }
  }

  String getMimeTypeFromBytes(Uint8List bytes) {
    return lookupMimeType('', headerBytes: bytes) ?? 'image/png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Map Screenshot')),
      body: (_startPoint == null || _endPoint == null)
          ? Center(child: CircularProgressIndicator())
          : Column(
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
