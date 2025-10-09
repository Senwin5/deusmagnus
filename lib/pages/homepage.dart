import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fa),
      appBar: AppBar(
        backgroundColor: const Color(0xff284a79),
        elevation: 0,
        title: const Text(
          "DeusMagnus",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔍 Search bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search properties, projects...",
                      suffixIcon: Icon(Icons.search, color: Color(0xff284a79)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 🌄 Hero banner
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/images/deusmagnus.png",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),

                // 🏗 Ongoing Projects
                const Text(
                  "Ongoing Projects",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildProjectCard(
                        "Mowe Warehouse",
                        "Ongoing",
                        "https://images.unsplash.com/photo-1503387762-592deb58ef4e",
                      ),
                      _buildProjectCard(
                        "Lagos Apartments",
                        "Planned",
                        "https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7",
                      ),
                      _buildProjectCard(
                        "Abuja Office Complex",
                        "Completed",
                        "https://images.unsplash.com/photo-1501594907352-04cda38ebc29",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ⚡ Quick actions
                const Text(
                  "Quick Actions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildActionCard("Projects", Icons.home, Colors.blue),
                      const SizedBox(width: 12),
                      _buildActionCard("Workers", Icons.groups, Colors.green),
                      const SizedBox(width: 12),
                      _buildActionCard(
                          "Services", Icons.real_estate_agent, Colors.teal),
                      const SizedBox(width: 12),
                      _buildActionCard("About", Icons.info, Colors.orange),
                      const SizedBox(width: 12),
                      _buildActionCard("Contact", Icons.phone, Colors.purple),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 🌟 Featured Properties (new carousel)
                const Text(
                  "Featured Properties",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 280,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFeaturedPropertyCard(
                        "Luxury Villa",
                        "Lagos",
                        "\$450,000",
                        "https://images.unsplash.com/photo-1599423300746-b62533397364",
                      ),
                      _buildFeaturedPropertyCard(
                        "Modern Apartment",
                        "Abuja",
                        "\$320,000",
                        "https://images.unsplash.com/photo-1572120360610-d971b9b63938",
                      ),
                      _buildFeaturedPropertyCard(
                        "Beach House",
                        "Lekki",
                        "\$780,000",
                        "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),

          // 🌟 Floating "Explore Projects" button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: const Color(0xff284a79),
              label: const Text("Explore Projects"),
              icon: const Icon(Icons.explore),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Reusable action card
  Widget _buildActionCard(String title, IconData icon, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // 🔹 Reusable project card
  Widget _buildProjectCard(String title, String status, String imageUrl) {
    Color statusColor = status == "Ongoing"
        ? Colors.blue
        : status == "Planned"
            ? Colors.orange
            : Colors.green;

    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text("Status: $status",
                    style: TextStyle(
                        color: statusColor, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Featured property card
  Widget _buildFeaturedPropertyCard(
      String title, String location, String price, String imageUrl) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.network(
                  imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 140,
                      color: Colors.grey[300],
                      child:
                          const Icon(Icons.image, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
              // Gradient overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        // ignore: deprecated_member_use
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(location, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),
                Text(price,
                    style: const TextStyle(
                        color: Color(0xff284a79), fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
