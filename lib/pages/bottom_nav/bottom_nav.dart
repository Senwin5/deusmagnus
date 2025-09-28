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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey[600],
        elevation: 10,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
          });  
        }, 
        items: const [   
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment),
            label: "Properties",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            label: "Projects",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
