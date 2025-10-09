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
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;
  File? _imageFile;
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        final data = userDoc.data();
        setState(() {
          _nameController.text = data?['name'] ?? user.displayName ?? '';
          _photoUrl = data?['photoUrl'] ?? user.photoURL;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() => _imageFile = File(pickedImage.path));
    }
  }

  Future<void> _saveProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);

    String? photoUrl = _photoUrl;

    try {
      // Upload new image if chosen
      if (_imageFile != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_profiles')
            .child('${user.uid}.jpg');

        await ref.putFile(_imageFile!);
        photoUrl = await ref.getDownloadURL();
      }

      // Update Firebase Auth profile
      await user.updateDisplayName(_nameController.text.trim());
      if (photoUrl != null) await user.updatePhotoURL(photoUrl);

      // Update Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'name': _nameController.text.trim(),
        'email': user.email,
        'photoUrl': photoUrl,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : (_photoUrl != null
                                  ? NetworkImage(_photoUrl!)
                                  : const AssetImage(
                                          'assets/images/default_avatar.png')
                                      as ImageProvider),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: _pickImage,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepPurple,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(Icons.edit,
                                  color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: user?.email ?? '',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: _saveProfile,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Changes'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
