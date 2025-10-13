import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturedPropertyDetails extends StatelessWidget {
  final Map<String, dynamic> property;

  const FeaturedPropertyDetails({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final String title = property['title'] ?? 'Property Details';
    final String location = property['location'] ?? 'Unknown';
    final String price = property['price'] ?? '';
    final String imageUrl = property['image'] ??
        'https://via.placeholder.com/400x300.png?text=No+Image';
    final String description =
        property['description'] ?? 'No detailed description available.';
    final double latitude =
        property['latitude'] is num ? property['latitude'].toDouble() : 6.5244;
    final double longitude = property['longitude'] is num
        ? property['longitude'].toDouble()
        : 3.3792;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
              ),
            ),
            const SizedBox(height: 16),
            Text(title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(location, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(price,
                style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff284a79),
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(description,
                style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 20),
            const Text("Property Map",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(latitude, longitude), zoom: 15),
                  markers: {
                    Marker(
                        markerId: const MarkerId("property"),
                        position: LatLng(latitude, longitude),
                        infoWindow: InfoWindow(title: title, snippet: location))
                  },
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.email_outlined),
                label: const Text("Enquire via Gmail"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff284a79),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  final nameController = TextEditingController();
                  final emailController = TextEditingController();
                  final messageController = TextEditingController();

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                          top: 24),
                      child: Wrap(
                        children: [
                          const Text("Send Enquiry",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                labelText: "Your Name",
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                labelText: "Email Address",
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: messageController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                                labelText: "Message",
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.send),
                              label: const Text("Send via Gmail"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff284a79),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14)),
                              onPressed: () {
                                final name = nameController.text.trim();
                                final email = emailController.text.trim();
                                final message = messageController.text.trim();

                                Navigator.pop(context); // auto-close modal

                                final mailtoUri = Uri(
                                  scheme: 'mailto',
                                  path: 'info@deusmagnus.com',
                                  queryParameters: {
                                    'subject': 'Enquiry: $title',
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
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
