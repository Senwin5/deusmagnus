import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../map/full_map_view.dart';

class OngoingProjectsDetails extends StatelessWidget {
  final Map<String, dynamic> project;

  const OngoingProjectsDetails({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final double progress = (project["progress"] is num)
        ? (project["progress"] as num).toDouble()
        : 0.65;

    final double latitude = (project["latitude"] is num)
        ? (project["latitude"] as num).toDouble()
        : 6.5244;

    final double longitude = (project["longitude"] is num)
        ? (project["longitude"] as num).toDouble()
        : 3.3792;

    final String imageUrl = project["image"] ??
        "https://images.unsplash.com/photo-1503387762-592deb58ef4e";

    return Scaffold(
      appBar: AppBar(
        title: Text(project["title"] ?? "Project Details"),
        backgroundColor: const Color(0xff284a79),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 220,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.broken_image,
                        size: 60, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              project["title"] ?? "Unnamed Project",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(project["location"] ?? "Unknown Location",
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),

            // Progress Bar
            Text("Project Progress",
                style: TextStyle(
                    color: Colors.grey[700], fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                minHeight: 10,
                color: Colors.blueAccent,
                backgroundColor: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 20),

            // Project Info
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Expanded(
                    child:
                        Text("Client: ${project["client"] ?? "Not specified"}")),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.assignment, color: Colors.orangeAccent),
                const SizedBox(width: 8),
                Expanded(
                    child: Text("Status: ${project["status"] ?? "Unknown"}")),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              project["description"] ??
                  "No detailed description provided for this project.",
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Project Map
            const Text("Project Map",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullMapView(
                        title: project["title"] ?? "Project Map",
                        latitude: latitude,
                        longitude: longitude,
                        landmarks: (project["landmarks"] as List?)
                            ?.cast<Map<String, dynamic>>(),
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: 200,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(latitude, longitude),
                      zoom: 15,
                    ),
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    markers: {
                      Marker(
                        markerId: const MarkerId("project"),
                        position: LatLng(latitude, longitude),
                        infoWindow: InfoWindow(
                          title: project["title"],
                          snippet: project["location"],
                        ),
                      ),
                    },
                    onTap: (_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullMapView(
                            title: project["title"] ?? "Project Map",
                            latitude: latitude,
                            longitude: longitude,
                            landmarks: (project["landmarks"] as List?)
                                ?.cast<Map<String, dynamic>>(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
