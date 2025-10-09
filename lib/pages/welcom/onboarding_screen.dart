import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:deusmagnus/registration/login.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        color: Color(0xff284a79),
      ),
      bodyTextStyle: TextStyle(fontSize: 18.0, color: Colors.black87),
      bodyPadding: EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 8.0), // ✅ updated here
      imagePadding: EdgeInsets.all(24),
      pageColor: Colors.white,
    );

    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Buy Your Dream Home",
          body:
              "Explore premium listings, compare options, and find your ideal property with ease.",
          image: Image.asset("assets/images/home1.png", height: 250),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Discover Luxury Properties",
          body:
              "Find apartments, villas, and houses that match your lifestyle and budget.",
          image: Image.asset("assets/images/home2.png", height: 250),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Start Your Real Estate Journey",
          body:
              "Buy, rent, or invest — everything you need is just a tap away with DeusMagnus.",
          image: Image.asset("assets/images/home3.png", height: 250),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true, // ✅ Added skip button
      skip: const Text("Skip",
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
      next: const Icon(Icons.arrow_forward, color: Colors.amber),
      done: const Text(
        "Get Started",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeColor: Color(0xff284a79),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      curve: Curves.easeInOut,
      animationDuration: 700, // ✅ smooth transitions
      globalBackgroundColor: Colors.white,
    );
  }
}
