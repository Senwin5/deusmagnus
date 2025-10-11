import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  String _selectedCategory = "All";

  // Sample blog/news data
  final List<Map<String, dynamic>> _blogs = [
    {
      "title": "Cybersecurity Trends 2025",
      "description":
          "Learn about the latest trends shaping the cybersecurity landscape this year.",
      "image": "https://www.deusmagnus.com/media/even_images/11.jpg",
      "date": "2025-10-01",
      "category": "News",
      "likes": 0,
    },
    {
      "title": "How to Protect Your Digital Identity",
      "description":
          "Tips and best practices to ensure your personal data stays safe online.",
      "image": "https://www.deusmagnus.com/media/guides_images/g5.jpg",
      "date": "2025-09-20",
      "category": "Guides",
      "likes": 0,
    },
    {
      "title": "AI in Cybersecurity",
      "description":
          "Explore how AI is transforming threat detection and prevention.",
      "image": "https://www.deusmagnus.com/media/even_images/n1.jpg",
      "date": "2025-09-15",
      "category": "News",
      "likes": 0,
    },
    {
      "title": "Weekly Security News",
      "description": "Catch up with the latest cybersecurity news this week.",
      "image": "https://www.deusmagnus.com/media/even_images/n3.jpg",
      "date": "2025-09-10",
      "category": "News",
      "likes": 0,
    },
    {
      "title": "Guide to Secure Passwords",
      "description":
          "Learn best practices for creating strong and secure passwords.",
      "image": "https://www.deusmagnus.com/media/guides_images/g4.jpg",
      "date": "2025-09-05",
      "category": "Guides",
      "likes": 0,
    },
    {
      "title": "Guide to Secure Passwords",
      "description":
          "Learn best practices for creating strong and secure passwords.",
      "image": "https://www.deusmagnus.com/media/guides_images/g4.jpg",
      "date": "2025-09-05",
      "category": "Guides",
      "likes": 0,
    },
    {
      "title": "Guide to Secure Passwords",
      "description":
          "Learn best practices for creating strong and secure passwords.",
      "image": "https://www.deusmagnus.com/media/guides_images/g4.jpg",
      "date": "2025-09-05",
      "category": "Guides",
      "likes": 0,
    },
    {
      "title": "Guide to Secure Passwords",
      "description":
          "Learn best practices for creating strong and secure passwords.",
      "image": "https://www.deusmagnus.com/media/guides_images/g4.jpg",
      "date": "2025-09-05",
      "category": "Guides",
      "likes": 0,
    },
  ];

  final List<String> _categories = ["All", "News", "Guides"];

  @override
  Widget build(BuildContext context) {
    final filteredBlogs = _selectedCategory == "All"
        ? _blogs
        : _blogs.where((b) => b['category'] == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog & News"),
        backgroundColor: const Color(0xff284a79),
      ),
      body: Column(
        children: [
          // Category filter
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = category),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff284a79)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Blog list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredBlogs.length,
              itemBuilder: (context, index) {
                final blog = filteredBlogs[index];
                final date =
                    DateFormat.yMMMMd().format(DateTime.parse(blog['date']));

                // Category color badge
                Color categoryColor =
                    blog['category'] == "News" ? Colors.blue : Colors.orange;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16)),
                        child: Image.network(
                          blog['image'],
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 180,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image,
                                size: 60, color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: categoryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                blog['category'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(blog['title'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(date,
                                style: const TextStyle(color: Colors.grey)),
                            const SizedBox(height: 6),
                            Text(blog['description'],
                                maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.thumb_up,
                                          color: Colors.blue),
                                      onPressed: () {
                                        setState(() => blog['likes'] += 1);
                                      },
                                    ),
                                    Text("${blog['likes']}"),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.share,
                                      color: Colors.green),
                                  onPressed: () {
                                    // ignore: deprecated_member_use
                                    Share.share(
                                        "${blog['title']}\n\n${blog['description']}");
                                  },
                                ),
                                TextButton(
                                  onPressed: () =>
                                      _showBlogDetails(context, blog),
                                  child: const Text("Read More"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showBlogDetails(BuildContext context, Map<String, dynamic> blog) {
    Color categoryColor =
        blog['category'] == "News" ? Colors.blue : Colors.orange;

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  blog['image'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child:
                        const Icon(Icons.image, size: 60, color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        blog['category'],
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(blog['title'],
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(
                        DateFormat.yMMMMd()
                            .format(DateTime.parse(blog['date'])),
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 12),
                    Text(blog['description'],
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
