import 'dart:async';
import 'package:flutter/material.dart';
import 'package:deusmagnus/pages/details/ongoing_projects_details.dart';
import 'package:deusmagnus/pages/projects.dart';
import 'package:deusmagnus/pages/blog_page.dart';
import 'package:deusmagnus/pages/services_page.dart';
import 'package:deusmagnus/pages/about_page.dart';
import 'package:deusmagnus/pages/contact_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PageController _heroController = PageController(viewportFraction: 0.9);
  final PageController _ongoingController =
      PageController(viewportFraction: 0.8);
  final PageController _featuredController =
      PageController(viewportFraction: 0.8);

  double _heroPage = 0.0;
  double _ongoingPage = 0.0;
  double _featuredPage = 0.0;

  int _currentHeroPage = 0;
  Timer? _autoScrollTimer;

  final List<String> heroImages = [
    "assets/images/deusmagnus.png",
    "assets/images/house1.png",
    "assets/images/house2.png",
    "assets/images/house3.png"
  ];

  @override
  void initState() {
    super.initState();
    _heroController.addListener(
        () => setState(() => _heroPage = _heroController.page ?? 0));
    _ongoingController.addListener(
        () => setState(() => _ongoingPage = _ongoingController.page ?? 0));
    _featuredController.addListener(
        () => setState(() => _featuredPage = _featuredController.page ?? 0));
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_heroController.hasClients) {
        _currentHeroPage++;
        if (_currentHeroPage >= heroImages.length) _currentHeroPage = 0;
        _heroController.animateToPage(
          _currentHeroPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _heroController.dispose();
    _ongoingController.dispose();
    _featuredController.dispose();
    super.dispose();
  }

  // 🔹 Updated ongoing projects with progress + coordinates
  final List<Map<String, dynamic>> ongoingProjects = [
    {
      "title": "Mowe Warehouse",
      "status": "Ongoing",
      "image": "https://images.unsplash.com/photo-1503387762-592deb58ef4e",
      "client": "Deus Logistics Ltd",
      "location": "Mowe, Ogun State",
      "description":
          "A large-scale warehouse complex designed for high-volume storage and logistics operations. Expected completion: Q3 2025.",
      "progress": 65,
      "latitude": 6.8198,
      "longitude": 3.4914,
    },
    {
      "title": "Lagos Apartments",
      "status": "Planned",
      "image": "https://www.deusmagnus.com/media/images_sub/1.JPG",
      "client": "Urban Living Developers",
      "location": "Lekki, Lagos",
      "description":
          "A 10-storey luxury apartment building with modern amenities and smart living technology.",
      "progress": 20,
      "latitude": 6.459964,
      "longitude": 3.601521,
    },
    {
      "title": "Abuja Office Complex",
      "status": "Completed",
      "image": "https://www.deusmagnus.com/media/images_sub/a3.jpg",
      "client": "TechFront HQ",
      "location": "Central Business District, Abuja",
      "description":
          "A state-of-the-art corporate office space with eco-friendly features and a rooftop terrace.",
      "progress": 100,
      "latitude": 9.05785,
      "longitude": 7.49508,
    },
    {
      "title": "Corporate Complex",
      "status": "Incompleted",
      "image": "https://www.deusmagnus.com/media/images_sub/RED_2_-_Photo.jpg",
      "client": "TechFront HQ",
      "location": "Victoria Island, Lagos",
      "description":
          "A premium office complex with integrated solar solutions and high-speed fiber connectivity.",
      "progress": 45,
      "latitude": 6.428055,
      "longitude": 3.421944,
    },
  ];

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
                _buildSearchBar(),
                const SizedBox(height: 20),
                _buildHeroBanner(),
                const SizedBox(height: 20),
                const Text("Ongoing Projects",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildOngoingProjects(),
                const SizedBox(height: 20),
                _buildQuickActions(),
                const SizedBox(height: 20),
                const Text("Featured Properties",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildFeaturedProjects(),
                const SizedBox(height: 80),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Projects())),
              backgroundColor: const Color(0xff284a79),
              label: const Text("Explore Projects"),
              icon: const Icon(Icons.explore),
            ),
          ),
        ],
      ),
    );
  }

  // 🔍 Search Bar
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search properties, projects...",
          suffixIcon: Icon(Icons.search, color: Color(0xff284a79)),
        ),
      ),
    );
  }

  // 🏙 Hero Banner
  Widget _buildHeroBanner() {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: _heroController,
        itemCount: heroImages.length,
        itemBuilder: (context, index) {
          double scale = (1 - (_heroPage - index).abs() * 0.1).clamp(0.9, 1.0);
          return Transform.scale(
            scale: scale,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(heroImages[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }

  // 🏗 Ongoing Projects Section
  Widget _buildOngoingProjects() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: _ongoingController,
        itemCount: ongoingProjects.length,
        itemBuilder: (context, index) {
          final project = ongoingProjects[index];
          double scale =
              (1 - (_ongoingPage - index).abs() * 0.1).clamp(0.9, 1.0);
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OngoingProjectsDetails(project: project),
              ),
            ),
            child: Transform.scale(
              scale: scale,
              child: _buildProjectCard(
                project["title"],
                project["status"],
                project["image"],
              ),
            ),
          );
        },
      ),
    );
  }

  // ⚡ Quick Actions
  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Quick Actions",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildActionCard(
                  "Projects", Icons.home, Colors.blue, const Projects()),
              const SizedBox(width: 12),
              _buildActionCard(
                  "Services", Icons.build, Colors.teal, const Services()),
              const SizedBox(width: 12),
              _buildActionCard(
                  "Blog", Icons.groups, Colors.green, const BlogPage()),
              const SizedBox(width: 12),
              _buildActionCard(
                  "About", Icons.info, Colors.orange, const About()),
              const SizedBox(width: 12),
              _buildActionCard(
                  "Contact", Icons.phone, Colors.purple, const Contact()),
            ],
          ),
        ),
      ],
    );
  }

  // 🌟 Featured Properties Section
  Widget _buildFeaturedProjects() {
    return SizedBox(
      height: 280,
      child: PageView.builder(
        controller: _featuredController,
        itemCount: 3,
        itemBuilder: (context, index) {
          double scale =
              (1 - (_featuredPage - index).abs() * 0.1).clamp(0.9, 1.0);
          return Transform.scale(
            scale: scale,
            child: _buildFeaturedPropertyCard(
              index == 0
                  ? "Luxury Villa"
                  : index == 1
                      ? "Modern Apartment"
                      : "Beach House",
              index == 0
                  ? "Lagos"
                  : index == 1
                      ? "Abuja"
                      : "Lekki",
              index == 0
                  ? "\$450,000"
                  : index == 1
                      ? "\$320,000"
                      : "\$780,000",
              index == 0
                  ? "https://images.unsplash.com/photo-1599423300746-b62533397364"
                  : index == 1
                      ? "https://images.unsplash.com/photo-1572120360610-d971b9b63938"
                      : "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
            ),
          );
        },
      ),
    );
  }

  // 🧩 Helper Widgets
  Widget _buildActionCard(
      String title, IconData icon, Color color, Widget page) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Container(
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
            Text(title,
                style: TextStyle(color: color, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(String title, String status, String imageUrl) {
    Color statusColor = status == "Ongoing"
        ? Colors.blue
        : status == "Planned"
            ? Colors.orange
            : Colors.green;

    return Container(
      width: 220,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
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

  Widget _buildFeaturedPropertyCard(
      String title, String location, String price, String imageUrl) {
    return Container(
      width: 220,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
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
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
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
