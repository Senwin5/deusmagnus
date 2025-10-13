import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../map/full_map_view.dart';

class OngoingProjectsDetails extends StatefulWidget {
  final Map<String, dynamic> project;

  const OngoingProjectsDetails({super.key, required this.project});

  @override
  State<OngoingProjectsDetails> createState() => _OngoingProjectsDetailsState();
}

class _OngoingProjectsDetailsState extends State<OngoingProjectsDetails> {
  @override
  Widget build(BuildContext context) {
    final double progress = (widget.project["progress"] is num)
        ? (widget.project["progress"] as num).toDouble()
        : 0.65;

    final double latitude = (widget.project["latitude"] is num)
        ? (widget.project["latitude"] as num).toDouble()
        : 6.5244;

    final double longitude = (widget.project["longitude"] is num)
        ? (widget.project["longitude"] as num).toDouble()
        : 3.3792;

    final String imageUrl = widget.project["image"] ??
        "https://images.unsplash.com/photo-1503387762-592deb58ef4e";

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project["title"] ?? "Project Details"),
        backgroundColor: const Color(0xff284a79),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showEnquiryForm(context),
        backgroundColor: Colors.orangeAccent,
        icon: const Icon(Icons.email_outlined),
        label: const Text("Book / Enquire"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image
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
                    child:
                        Icon(Icons.broken_image, size: 60, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Title & Location
            Text(
              widget.project["title"] ?? "Unnamed Project",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.project["location"] ?? "Unknown Location",
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            // Progress
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
            // Client & Status
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(
                        "Client: ${widget.project["client"] ?? "Not specified"}")),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.assignment, color: Colors.orangeAccent),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(
                        "Status: ${widget.project["status"] ?? "Unknown"}")),
              ],
            ),
            const SizedBox(height: 20),
            // Description
            Text(
              widget.project["description"] ??
                  "No detailed description provided for this project.",
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            // Map
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
                        title: widget.project["title"] ?? "Project Map",
                        latitude: latitude,
                        longitude: longitude,
                        landmarks: (widget.project["landmarks"] as List?)
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
                          title: widget.project["title"],
                          snippet: widget.project["location"],
                        ),
                      ),
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  // 🔹 Enquiry Form with Gmail auto-close
  void _showEnquiryForm(BuildContext context) {
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _messageController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: Form(
          key: _formKey,
          child: Wrap(
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Project Booking / Enquiry",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Your Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter your name" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter your email";
                  final emailRegex = RegExp(
                      r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
                  if (!emailRegex.hasMatch(value)) return "Enter a valid email";
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _messageController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Message / Booking Details",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter a message" : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff284a79),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.send),
                  label: const Text(
                    "Send Enquiry",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    final name = _nameController.text.trim();
                    final email = _emailController.text.trim();
                    final message = _messageController.text.trim();
                    final projectTitle = widget.project['title'] ?? '';

                    // 🔹 Auto-close modal first
                    Navigator.pop(context);

                    // 🔹 Open Gmail / default email app
                    final mailtoUri = Uri(
                      scheme: 'mailto',
                      path: 'godwin@deusmagnus.com',
                      queryParameters: {
                        'subject': 'Enquiry: $projectTitle',
                        'body':
                            'Name: $name\nEmail: $email\nMessage:\n$message',
                      },
                    );

                    launchUrl(mailtoUri);
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
