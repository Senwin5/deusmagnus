import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  // Sample blog/news data
  final List<Map<String, dynamic>> _blogs = const [
    {
      "title": "Cybersecurity Trends 2025",
      "description": "Learn about the latest trends shaping the cybersecurity landscape this year.",
      "image": "https://images.unsplash.com/photo-1581091870627-6d8a9aa644fa?auto=format&fit=crop&w=800&q=80",
      "date": "2025-10-01"
    },
    {
      "title": "How to Protect Your Digital Identity",
      "description": "Tips and best practices to ensure your personal data stays safe online.",
      "image": "https://images.unsplash.com/photo-1605902711622-cfb43c4439ec?auto=format&fit=crop&w=800&q=80",
      "date": "2025-09-20"
    },
    {
      "title": "AI in Cybersecurity",
      "description": "Explore how AI is transforming threat detection and prevention.",
      "image": "https://images.unsplash.com/photo-1618401475976-391f8c987b2f?auto=format&fit=crop&w=800&q=80",
      "date": "2025-09-15"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog & News"),
        backgroundColor: const Color(0xff284a79),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _blogs.length,
        itemBuilder: (context, index) {
          final blog = _blogs[index];
          final date = DateFormat.yMMMMd().format(DateTime.parse(blog['date']));
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    blog['image'],
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 180,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 60, color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog['title'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        date,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        blog['description'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Open full blog/news details
                            _showBlogDetails(context, blog);
                          },
                          child: const Text("Read More"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showBlogDetails(BuildContext context, Map<String, dynamic> blog) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  blog['image'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 60, color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(blog['title'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(
                      DateFormat.yMMMMd().format(DateTime.parse(blog['date'])),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    Text(blog['description'], style: const TextStyle(fontSize: 16)),
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
