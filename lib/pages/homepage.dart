import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/demo.mp4")
      ..initialize().then((_) {
        setState(() {}); // refresh once video is ready
        _controller.play(); // autoplay
        _controller.setLooping(true); // loop forever
        _controller.setVolume(0); // mute
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 237, 239),
      appBar: AppBar(
        title: const Text("DeusMagnus", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search bar
            Container(
              padding: const EdgeInsets.only(left: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "How can I help you?",
                  hintStyle: TextStyle(color: Colors.black45),
                  suffixIcon: Icon(Icons.search, color: Color(0xff284a79)),
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            // 🎥 Banner video
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(
                      height: 320,
                      color: Colors.black12,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
            ),
            const SizedBox(height: 20.0),

            // 👷 Welcome text
            const Text(
              "Explore 👷‍♂️",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "At Deus Magnus, we redefine excellence in construction, real estate, and facility management across Nigeria.",
              style: TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 20.0),

            // 🏗 Ongoing projects
            const Text(
              "Ongoing Projects",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),

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

            // 🌟 Favourite
            const Text(
              "Favourite Projects",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),

            // ⚡ Quick actions
            SizedBox(
              height: 95,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildActionCard(
                      title: "Projects",
                      icon: Icons.home,
                      color: Colors.blue,
                      onTap: () {},
                    ),
                    const SizedBox(width: 12),
                    _buildActionCard(
                      title: "Workers",
                      icon: Icons.groups,
                      color: Colors.green,
                      onTap: () {},
                    ),
                    const SizedBox(width: 12),
                    _buildActionCard(
                      title: "Services",
                      icon: Icons.real_estate_agent,
                      color: Colors.teal,
                      onTap: () {},
                    ),
                    const SizedBox(width: 12),
                    _buildActionCard(
                      title: "About",
                      icon: Icons.info,
                      color: Colors.orange,
                      onTap: () {},
                    ),
                    const SizedBox(width: 12),
                    _buildActionCard(
                      title: "Contact",
                      icon: Icons.phone,
                      color: Colors.purple,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            // 🌟 Featured
            const Text(
              "Featured Projects",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),

            // 🛠 Example service card
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/deusmagnus.png",
                    height: 120,
                    width: 220,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5.0),
                    const Text(
                      "Repairing",
                      style: TextStyle(
                        color: Color(0xff284a79),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "by Temu",
                      style: TextStyle(
                        color: Color(0xff284a79),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 94, 172, 202),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "View",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Reusable action card widget
  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
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
      ),
    );
  }

  // 🔹 Reusable project card widget
  Widget _buildProjectCard(String title, String status, String imageUrl) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
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
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Status: $status",
                  style: TextStyle(
                    color: status == "Ongoing"
                        ? Colors.blue
                        : status == "Planned"
                            ? Colors.orange
                            : Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
