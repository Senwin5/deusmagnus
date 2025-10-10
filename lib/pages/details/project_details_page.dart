import 'package:flutter/material.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ProjectDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f6fa),
      appBar: AppBar(
        backgroundColor: const Color(0xff284a79),
        title: Text(
          data['title'] ?? 'Project Details',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Hero Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                data['image'] ?? '',
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 220,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported,
                      size: 60, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 Title & Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    data['title'] ?? 'Untitled Project',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff284a79),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: (data['status'] == 'Ongoing')
                        ? Colors.blue.shade100
                        : (data['status'] == 'Completed')
                            ? Colors.green.shade100
                            : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    data['status'] ?? 'Unknown',
                    style: TextStyle(
                      color: (data['status'] == 'Ongoing')
                          ? Colors.blue.shade900
                          : (data['status'] == 'Completed')
                              ? Colors.green.shade900
                              : Colors.orange.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 🔹 Decorative Divider
            Container(
              height: 3,
              width: 80,
              color: Colors.amber,
              margin: const EdgeInsets.only(bottom: 16),
            ),

            // 🔹 Info Cards (fake data just to look rich visually)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _infoCard(Icons.calendar_today, 'Start', 'June 2025'),
                _infoCard(Icons.engineering, 'Team', '12 Experts'),
                _infoCard(Icons.home_work, 'Type', 'Construction'),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Project Description
            const Text(
              "Project Overview",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff284a79),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              data['description'] ??
                  "No description provided. This project is one of DeusMagnus's core initiatives in construction and engineering excellence.",
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),

            // 🔹 Additional Info Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Key Highlights",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xff284a79),
                    ),
                  ),
                  SizedBox(height: 12),
                  ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.amber),
                    title: Text("High-quality materials used"),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.amber),
                    title: Text("Sustainable and eco-friendly design"),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.amber),
                    title: Text("Delivered by expert DeusMagnus engineers"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 Client Testimonial Placeholder
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffeaf0f9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.format_quote, color: Colors.amber, size: 40),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "\"We are extremely satisfied with DeusMagnus’s attention to detail and commitment to quality.\"",
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 Contact CTA
            Center(
              child: Column(
                children: [
                  const Text(
                    "Interested in similar projects?",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone, color: Colors.white),
                    label: const Text("Contact DeusMagnus"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff284a79),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 🔸 Info Card Widget
  Widget _infoCard(IconData icon, String label, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xff284a79), size: 24),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
