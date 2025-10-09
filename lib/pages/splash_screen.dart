import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:deusmagnus/pages/bottom_nav/bottom_nav.dart';
import 'package:deusmagnus/registration/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), _checkUserAuth);
  }

  Future<void> _checkUserAuth() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // ✅ User already logged in → go to home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNav()),
      );
    } else {
      // 🚪 No user logged in → go to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff284a79),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🏠 Your App Logo
            Image.asset(
              'assets/images/logo.png', // 👈 make sure this path matches your logo
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 30),

            // ✨ App name or tagline
            const Text(
              "Deus Magnus Realty",
              style: TextStyle(
                fontSize: 26,
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
