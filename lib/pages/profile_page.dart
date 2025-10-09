import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;
  bool isLoading = true;
  bool isEditing = false;
  TextEditingController nameController = TextEditingController();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fetch user info from Firestore
  Future<void> fetchUserData() async {
    if (user == null) return;

    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (snapshot.exists) {
        userData = snapshot.data() as Map<String, dynamic>;
        nameController.text = userData?['fullName'] ?? '';
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error loading profile: $e")));
    }

    setState(() => isLoading = false);
  }

  // Pick image from gallery
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Upload profile image to Firebase Storage
  Future<String?> uploadProfileImage() async {
    if (_imageFile == null || user == null) return null;

    final ref =
        FirebaseStorage.instance.ref().child('profile_pics/${user!.uid}.jpg');

    await ref.putFile(_imageFile!);
    return await ref.getDownloadURL();
  }

  // Save profile updates
  Future<void> saveProfile() async {
    if (user == null) return;

    setState(() => isLoading = true);
    String name = nameController.text.trim();
    String? imageUrl = userData?['photoUrl'];

    try {
      if (_imageFile != null) {
        imageUrl = await uploadProfileImage();
      }

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'fullName': name,
        'photoUrl': imageUrl,
      });

      await user!.updateDisplayName(name);
      if (imageUrl != null) await user!.updatePhotoURL(imageUrl);

      await fetchUserData();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );

      setState(() => isEditing = false);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error saving profile: $e")));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xff284a79),
        actions: [
          if (!isEditing)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.amber),
              onPressed: () => setState(() => isEditing = true),
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(child: Text("No user data available"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: isEditing ? pickImage : null,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : (userData!['photoUrl'] != null
                                  ? NetworkImage(userData!['photoUrl'])
                                  : const AssetImage(
                                      'assets/images/default_avatar.png'))
                                  as ImageProvider,
                          backgroundColor: const Color(0xff284a79),
                          child: (_imageFile == null &&
                                  userData!['photoUrl'] == null)
                              ? const Icon(Icons.person,
                                  color: Colors.white, size: 60)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Name field
                      isEditing
                          ? TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                labelText: "Full Name",
                                border: OutlineInputBorder(),
                              ),
                            )
                          : Text(
                              userData!['fullName'] ?? 'No name',
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                      const SizedBox(height: 10),

                      // Email (read-only)
                      Text(
                        userData!['email'] ?? 'No email',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 30),

                      if (isEditing)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: saveProfile,
                              icon: const Icon(Icons.save),
                              label: const Text("Save"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12),
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton.icon(
                              onPressed: () => setState(() => isEditing = false),
                              icon: const Icon(Icons.cancel),
                              label: const Text("Cancel"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12),
                              ),
                            ),
                          ],
                        )
                      else
                        ElevatedButton.icon(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(context, '/login');
                            }
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text("Logout"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }
}
