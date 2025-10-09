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

  final List<Map<String, String>> pages = [
    {
      "title": "Buy Your Dream Home",
      "subtitle": "Explore and find your perfect property",
    },
    {
      "title": "Invest in Projects",
      "subtitle": "Discover ongoing and upcoming projects",
    },
    {
      "title": "Manage Properties",
      "subtitle": "Easily manage your properties in one app",
    },
  ];

  void _nextPage() {
    if (currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _finishOnboarding();
    }
  }

  Future<void> _finishOnboarding() async {
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) => setState(() => currentPage = index),
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Replace with image if needed
                      const Icon(Icons.home,
                          size: 120, color: Colors.blueAccent),
                      const SizedBox(height: 40),
                      Text(
                        pages[index]["title"]!,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        pages[index]["subtitle"]!,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: currentPage == index ? 20 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color:
                        currentPage == index ? Colors.blueAccent : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _finishOnboarding,
                    child: const Text("Skip"),
                  ),
                  ElevatedButton(
                    onPressed: _nextPage,
                    child:
                        Text(currentPage == pages.length - 1 ? "Done" : "Next"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
