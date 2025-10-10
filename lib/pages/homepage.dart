import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Controllers for Hero, Ongoing, and Featured carousels
  final PageController _heroController = PageController(viewportFraction: 0.9);
  final PageController _ongoingController =
      PageController(viewportFraction: 0.8);
  final PageController _featuredController =
      PageController(viewportFraction: 0.8);

  double _heroPage = 0.0;
  double _ongoingPage = 0.0;
  double _featuredPage = 0.0;

  @override
  void initState() {
    super.initState();

    _heroController.addListener(() {
      setState(() {
        _heroPage = _heroController.page!;
      });
    });
    _ongoingController.addListener(() {
      setState(() {
        _ongoingPage = _ongoingController.page!;
      });
    });
    _featuredController.addListener(() {
      setState(() {
        _featuredPage = _featuredController.page!;
      });
    });
  }

  @override
  void dispose() {
    _heroController.dispose();
    _ongoingController.dispose();
    _featuredController.dispose();
    super.dispose();
  }

  final List<String> heroImages = [
    "assets/images/deusmagnus.png", // local asset
    "assets/images/house1.png",
    "assets/images/house2.png",
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

                // 🌄 Hero banner carousel (local assets)
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _heroController,
                    itemCount: heroImages.length,
                    itemBuilder: (context, index) {
                      double scale = (_heroPage - index).abs() < 1
                          ? 1 - (_heroPage - index).abs() * 0.1
                          : 0.9;
                      return Transform.scale(
                        scale: scale,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            heroImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // 🏗 Ongoing Projects (network images)
                const Text(
                  "Ongoing Projects",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    controller: _ongoingController,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      double scale = (_ongoingPage - index).abs() < 1
                          ? 1 - (_ongoingPage - index).abs() * 0.1
                          : 0.9;
                      return Transform.scale(
                        scale: scale,
                        child: _buildProjectCard(
                          index == 0
                              ? "Mowe Warehouse"
                              : index == 1
                                  ? "Lagos Apartments"
                                  : "Abuja Office Complex",
                          index == 0
                              ? "Ongoing"
                              : index == 1
                                  ? "Planned"
                                  : "Completed",
                          index == 0
                              ? "https://images.unsplash.com/photo-1503387762-592deb58ef4e"
                              : index == 1
                                  ? "https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7"
                                  : "https://images.unsplash.com/photo-1501594907352-04cda38ebc29",
                        ),
                      );
                    },
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

                // 🌟 Featured Properties (network images)
                const Text(
                  "Featured Properties",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 280,
                  child: PageView.builder(
                    controller: _featuredController,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      double scale = (_featuredPage - index).abs() < 1
                          ? 1 - (_featuredPage - index).abs() * 0.1
                          : 0.9;
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
          Text(title,
              style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ],
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
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
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
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          // ignore: deprecated_member_use
                          Colors.black.withOpacity(0.6)
                        ]),
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
