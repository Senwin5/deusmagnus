import 'dart:async';
import 'package:flutter/material.dart';
import 'package:deusmagnus/pages/welcom/onboarding_screen.dart';
import 'package:deusmagnus/registration/login.dart';
import 'package:deusmagnus/pages/bottom_nav/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), _checkStatus);
  }

  Future<void> _checkStatus() async {
    await SharedPreferences.getInstance();

    // 🔹 Force onboarding for testing
    bool hasSeenOnboarding = false; // always false during testing

    User? user = FirebaseAuth.instance.currentUser;

    if (!hasSeenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    // ignore: dead_code
    } else if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNav()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/house1.png', // static splash background
            fit: BoxFit.cover,
          ),
          // ignore: deprecated_member_use
          Container(color: Colors.black.withOpacity(0.3)), // dark overlay
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 120,
                ),
                const SizedBox(height: 20),
                const Text(
                  'DeusMagnus',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 40),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
