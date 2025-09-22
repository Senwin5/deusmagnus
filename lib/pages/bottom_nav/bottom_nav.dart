import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:deusmagnus/pages/homepage.dart';
import 'package:deusmagnus/pages/profile_page.dart';
import 'package:deusmagnus/pages/projects.dart';
import 'package:deusmagnus/pages/properties.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;

  late Homepage homepage;
  late Properties properties;
  late Projects projects;
  late ProfilePage profilePage;

  int currentTabIndex = 0;

  @override
  void initState() {
    homepage = Homepage();
    properties = Properties();
    projects = Projects();
    profilePage = ProfilePage();
    pages = [homepage, properties, projects, profilePage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTabIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: currentTabIndex,
        height: 60.0,
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        buttonBackgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 120),
        items: const <Widget>[
          Icon(Icons.home, size: 25, color: Colors.white),
          Icon(Icons.apartment, size: 25, color: Colors.white),
          Icon(Icons.business_center, size: 25, color: Colors.white),
          Icon(Icons.person, size: 25, color: Colors.white),
        ],
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
      ),
    );
  }
}
