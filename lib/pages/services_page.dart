import 'package:flutter/material.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // List of services
    final services = [
      {
        "icon": Icons.security,
        "title": "Cybersecurity",
        "description":
            "Protect your business and data from cyber threats with advanced security solutions."
      },
      {
        "icon": Icons.cloud,
        "title": "Cloud Solutions",
        "description":
            "Reliable cloud hosting, storage, and collaboration tools tailored for your needs."
      },
      {
        "icon": Icons.analytics,
        "title": "Data Analytics",
        "description":
            "Turn your data into actionable insights for smarter business decisions."
      },
      {
        "icon": Icons.mobile_friendly,
        "title": "Mobile Development",
        "description":
            "Build secure, high-performance mobile apps for Android and iOS platforms."
      },
      {
        "icon": Icons.web,
        "title": "Web Development",
        "description":
            "Modern, responsive websites designed to drive engagement and conversions."
      },
      {
        "icon": Icons.support_agent,
        "title": "Consulting & Support",
        "description":
            "Expert guidance to optimize operations and solve complex technical challenges."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Services"),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Icon(Icons.design_services, size: 80, color: Colors.blueAccent),
                  const SizedBox(height: 12),
                  Text(
                    "Our Services",
                    style: theme.textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "We provide a wide range of professional solutions tailored for your needs.",
                    style: theme.textTheme.titleMedium!.copyWith(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            // Services Grid
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: services.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final service = services[index];
                return _buildServiceCard(
                  icon: service['icon'] as IconData,
                  title: service['title'] as String,
                  description: service['description'] as String,
                );
              },
            ),

            const SizedBox(height: 32),

            // Call to Action
            Center(
              child: Column(
                children: [
                  Text(
                    "Want to know more?",
                    style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      // You can navigate to Contact page
                    },
                    icon: const Icon(Icons.contact_mail),
                    label: const Text("Contact Us"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each service card
  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
