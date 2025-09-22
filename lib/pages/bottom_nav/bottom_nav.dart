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
  //Creating a bottom navigation display list for bottom navigation bar

  late List<Widget> pages;

  late Homepage homepage;
  late Properties properties;
  late Projects projects;
  late ProfilePage profilePage;

  int currentTabIndex = 0;

  //After the int currentTabIndex = 0, you will have to create initstate

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
    return Container();
  }
}
