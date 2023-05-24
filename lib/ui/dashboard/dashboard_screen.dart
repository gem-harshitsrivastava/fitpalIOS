import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gem_fitpal/ui/dashboard/analytics_screen.dart';
import 'package:gem_fitpal/ui/dashboard/home_screen.dart';
import 'package:gem_fitpal/ui/dashboard/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  @override
  void initState() {
    setState(() {
      _selectedIndex = 1;
    });
    super.initState();
  }

  List<Widget> dashboardOptions = const <Widget>[
    HomeScreen(),
    AnalyticsScreen(),
    ProfileScreen()
    // Container(
    //   color: Colors.amber,
    //   child: const Text('Home'),
    // ),
    // Container(
    //   color: Colors.green,
    //   child: const Text('Dashboard'),
    // ),
    // Container(
    //   color: Colors.pink,
    //   child: const Text('Profile'),
    // )
  ];

  void _onTap(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.white),
      child: Scaffold(
        body: SafeArea(
          child: Center(child: dashboardOptions.elementAt(_selectedIndex)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.analytics), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
          ],
          currentIndex: _selectedIndex,
          iconSize: 34,
          selectedItemColor: const Color(0xff0066EE),
          onTap: _onTap,
        ),
      ),
    );
  }
}
