import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = Colors.grey[800];

    return Scaffold(
      appBar: AppBar(
        title: const Text("About DeusMagnus"),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const Icon(Icons.security,
                        size: 80, color: Colors.blueAccent),
                    const SizedBox(height: 12),
                    Text(
                      "DeusMagnus",
                      style: theme.textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Empowering Secure Digital Evolution",
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),

              // Mission Card
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(Icons.flag_rounded,
                          color: Colors.indigo, size: 40),
                      const SizedBox(height: 10),
                      Text(
                        "Our Mission",
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "We uphold transparency, trust, and ethical standards in all we do. "
                        "We strive to provide cutting-edge cybersecurity and digital intelligence solutions "
                        "that empower individuals, startups, and enterprises.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          height: 1.4,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Vision Card
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: Colors.blueGrey[900],
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(Icons.visibility_rounded,
                          color: Colors.white, size: 40),
                      const SizedBox(height: 10),
                      Text(
                        "Our Vision",
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "To create a safer digital ecosystem by blending innovation, ethics, and intelligence.",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white70, height: 1.4, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Core Values
              Text(
                "Our Core Values",
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildValueCard(Icons.shield_rounded, "Integrity",
                      "We uphold transparency, trust, and ethical standards in all we do."),
                  _buildValueCard(Icons.lightbulb_outline, "Innovation",
                      "Constantly pushing the boundaries of creativity and technology."),
                  _buildValueCard(Icons.handshake_rounded, "Collaboration",
                      "We build strong partnerships to drive meaningful change."),
                  _buildValueCard(Icons.star_rounded, "Excellence",
                      "Delivering quality and value beyond expectations."),
                ],
              ),

              const SizedBox(height: 32),

              // Social / Contact Section
              Center(
                child: Column(
                  children: [
                    Text(
                      "Connect With Us",
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebook,
                              color: Colors.blueAccent),
                          onPressed: null,
                        ),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.twitter,
                              color: Colors.lightBlue),
                          onPressed: null,
                        ),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.linkedin,
                              color: Colors.blueGrey),
                          onPressed: null,
                        ),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.instagram,
                              color: Colors.pinkAccent),
                          onPressed: null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "© 2025 DeusMagnus | All rights reserved",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for Core Values cards
  Widget _buildValueCard(IconData icon, String title, String description) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: Colors.indigo),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 13, height: 1.3, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
