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
//   Position? _currentPosition;
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   _getCurrentLocation() {
//     Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.best,
//       forceAndroidLocationManager: true,
//     ).then((Position position) {
//       setState(() {
//         print("_currentPosition: $position");
//         _currentPosition = position;
//         MapsLauncher.launchQuery(
//             '${position.latitude}, ${position.longitude}');
//       });
//     }).catchError((e) {
//       print("Error getting location: $e");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Location"),
//       ),
//       body: Center(
//         child:  Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "LAT: ${_currentPosition!.latitude}, LNG: ${_currentPosition!.longitude}",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


  GoogleMapController? _mapController;
  ScreenshotController screenshotController = ScreenshotController();

  LatLng? startLatLng;
  LatLng? endLatLng;
  Set<Polyline> _polylines = {};
  String? etaText;

  final String startAddress = "motijheel, dhaka";
  final String endAddress = "middle badda, dhaka";

  @override
  void initState() {
    super.initState();
    _loadRouteAndETA();
  }

  Future<void> _loadRouteAndETA() async {
    List<Location> startLocations = await locationFromAddress(startAddress);
    List<Location> endLocations = await locationFromAddress(endAddress);

    startLatLng = LatLng(startLocations.first.latitude, startLocations.first.longitude);
    endLatLng = LatLng(endLocations.first.latitude, endLocations.first.longitude);

    await _getDirectionPolylineAndETA();
  }

  Future<void> _getDirectionPolylineAndETA() async {
    final String apiKey = 'AIzaSyC3NpcTc3Wdtn68VCsf7ZxswuDzlNvvt9c'; // Replace with your API Key

    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startLatLng!.latitude},${startLatLng!.longitude}&destination=${endLatLng!.latitude},${endLatLng!.longitude}&mode=transit&transit_mode=bus&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    if (data['routes'].isNotEmpty) {
      final route = data['routes'][0];
      final points = route['overview_polyline']['points'];
      final legs = route['legs'][0];

      setState(() {
        etaText = legs['duration']['text']; // e.g., "36 mins"
        _polylines.add(
          Polyline(
            polylineId: PolylineId("bus_route"),
            points: _decodePolyline(points),
            color: Colors.green,
            width: 6,
          ),
        );
      });
    } else {
      setState(() {
        etaText = "No route found.";
      });
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }

  Future<void> _captureScreenshotAsBase64() async {
    final image = await screenshotController.capture();
    if (image != null) {
      String base64Image = base64Encode(image);
      print("Base64 Image:\n$base64Image");
      // You can now use or upload this Base64 string
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Route: Motijheel → Badda"),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _captureScreenshotAsBase64,
          )
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Column(
          children: [
            if (etaText != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.black38,
                child: Text(
                  "Estimated Time (Bus): $etaText",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

            Expanded(
              child: (startLatLng == null || endLatLng == null)
                  ? Center(child: CircularProgressIndicator())
                  : GoogleMap(
                initialCameraPosition: CameraPosition(target: startLatLng!, zoom: 15),
                onMapCreated: (controller) => _mapController = controller,
                markers: {
                  Marker(markerId: MarkerId("start"), position: startLatLng!),
                  Marker(markerId: MarkerId("end"), position: endLatLng!),
                },
                polylines: _polylines,
              ),
            ),
          ],
        ),
      ),
    );
  }

}