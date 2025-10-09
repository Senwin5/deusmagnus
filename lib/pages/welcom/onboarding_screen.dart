import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deusmagnus/registration/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Buy Your Dream Home",
      "description": "Find and purchase your perfect property with ease.",
      "image": "assets/images/house1.png",
    },
    {
      "title": "Discover Projects",
      "description": "Explore real estate projects in your area.",
      "image": "assets/images/house2.png",
    },
    {
      "title": "Manage Properties",
      "description": "Keep track of your properties efficiently.",
      "image": "assets/images/house3.png",
    },
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => currentPage = index),
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    onboardingData[index]['image']!,
                    height: 250,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    onboardingData[index]['title']!,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff284a79)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      onboardingData[index]['description']!,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.grey, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          ),
          // Skip button
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: _completeOnboarding,
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.amber, fontSize: 16),
              ),
            ),
          ),
          // Next / Done button
          Positioned(
            bottom: 50,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                if (currentPage == onboardingData.length - 1) {
                  _completeOnboarding();
                } else {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff284a79),
              ),
              child: Text(
                currentPage == onboardingData.length - 1 ? "Done" : "Next",
              ),
            ),
          ),
          // Dots indicator
          Positioned(
            bottom: 60,
            left: 30,
            child: Row(
              children: List.generate(
                onboardingData.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPage == index ? 12 : 8,
                  height: currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? const Color(0xff284a79)
                        : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
