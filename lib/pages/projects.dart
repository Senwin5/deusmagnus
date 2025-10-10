import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 📄 Project Details Page
class ProjectDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const ProjectDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['title'] ?? 'Project Details'),
        backgroundColor: const Color(0xff284a79),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data['image'] != null && data['image'].isNotEmpty)
              Hero(
                tag: data['title'],
                child: Image.network(
                  data['image'],
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 240,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data['status'] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: data['status'] == "Ongoing"
                          ? Colors.blue
                          : data['status'] == "Completed"
                              ? Colors.green
                              : Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data['description'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🧱 Projects Main Page
class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool get isAdmin => _user?.email == "godwin@deusmagnus.com";

  @override
  void initState() {
    super.initState();
    _auth.userChanges().listen((user) {
      setState(() => _user = user);
    });
  }

  // ➕ Add New Project (admin only)
  Future<void> _addProjectDialog() async {
    final titleController = TextEditingController();
    final statusController = TextEditingController();
    final imageController = TextEditingController();
    final descriptionController = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add New Project"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: statusController,
                decoration: const InputDecoration(labelText: "Status (e.g. Ongoing)"),
              ),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(labelText: "Image URL"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection('projects').add({
                'title': titleController.text.trim(),
                'status': statusController.text.trim(),
                'image': imageController.text.trim(),
                'description': descriptionController.text.trim(),
                'createdAt': FieldValue.serverTimestamp(),
              });
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // 🗑 Delete project (admin only)
  Future<void> _deleteProject(String id) async {
    await FirebaseFirestore.instance.collection('projects').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects"),
        backgroundColor: const Color(0xff284a79),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('projects')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No projects found"));
          }

          final projects = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              final data = project.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProjectDetailsPage(data: data),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (data['image'] != null && data['image'].isNotEmpty)
                        Hero(
                          tag: data['title'],
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.network(
                              data['image'],
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
                        ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title'] ?? 'Untitled Project',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              data['status'] ?? 'Unknown status',
                              style: TextStyle(
                                color: data['status'] == "Ongoing"
                                    ? Colors.blue
                                    : data['status'] == "Completed"
                                        ? Colors.green
                                        : Colors.orange,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              (data['description'] ?? '').length > 80
                                  ? '${data['description'].substring(0, 80)}...'
                                  : data['description'] ?? '',
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProjectDetailsPage(data: data),
                                    ),
                                  );
                                },
                                child: const Text("Read More →"),
                              ),
                            ),
                            if (isAdmin)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _deleteProject(project.id),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      // ➕ Only admin can see Add button
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              backgroundColor: const Color(0xff284a79),
              onPressed: _addProjectDialog,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
