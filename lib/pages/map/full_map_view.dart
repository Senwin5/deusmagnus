import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullMapView extends StatelessWidget {
  final String? title;
  final double latitude;
  final double longitude;
  final List<Map<String, dynamic>>? landmarks;

  const FullMapView({
    super.key,
    this.title,
    required this.latitude,
    required this.longitude,
    this.landmarks,
  });

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('main_project'),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: title ?? 'Project Site'),
      ),
    };

    if (landmarks != null) {
      for (var i = 0; i < landmarks!.length; i++) {
        final landmark = landmarks![i];
        markers.add(
          Marker(
            markerId: MarkerId('landmark_$i'),
            position: LatLng(
              (landmark['lat'] as num).toDouble(),
              (landmark['lng'] as num).toDouble(),
            ),
            infoWindow: InfoWindow(title: landmark['name']),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Full Map View'),
        backgroundColor: const Color(0xff284a79),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15,
        ),
        markers: markers,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }
}
