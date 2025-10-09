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

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  // List of house images
  final List<String> _images = [
    'assets/images/house1.png',
    'assets/images/house2.png',
    'assets/images/house3.png',
  ];

  int _currentImageIndex = 0;
  Timer? _imageTimer;

  @override
  void initState() {
    super.initState();

    // Fade animation setup
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // Change image every second
    _imageTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _images.length;
        _controller.reset();
        _controller.forward();
      });
    });

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), _checkStatus);
  }

  Future<void> _checkStatus() async {
    final prefs = await SharedPreferences.getInstance();

    // For debugging: force onboarding to appear
    // await prefs.setBool('hasSeenOnboarding', false);

    bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    User? user = FirebaseAuth.instance.currentUser;

    if (!hasSeenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
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
  void dispose() {
    _controller.dispose();
    _imageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Animated house background
          FadeTransition(
            opacity: _fadeAnimation,
            child: Image.asset(
              _images[_currentImageIndex],
              fit: BoxFit.cover,
            ),
          ),
          // Overlay to darken background
          Container(color: Colors.black.withOpacity(0.3)),
          // Center content
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
