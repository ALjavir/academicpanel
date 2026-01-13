import 'package:academicpanel/features/home/page/home_page_main.dart';
import 'package:academicpanel/features/schedule/page/schedule_page_main.dart';
import 'package:academicpanel/navigation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<BottomNavbar> {
  final RoutesController routesController = RoutesController();
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  List<Widget> _screens() => [HomePageMain(), SchedulePageMain()];

  List<PersistentBottomNavBarItem> _items() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: "Home",
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.search),
      title: "Search",
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      animationSettings: NavBarAnimationSettings(
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          curve: Curves.easeInOut,
          duration: Duration(seconds: 1),
        ),
      ),
      context,
      controller: _controller,
      screens: _screens(),
      items: _items(),
      navBarStyle: NavBarStyle.style7,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(borderRadius: BorderRadius.circular(16)),
    );
  }
}
