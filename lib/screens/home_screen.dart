import 'package:flutter/material.dart';
import '../theme.dart';
import 'rider_find_screen.dart';
import 'driver_offer_screen.dart';
import 'my_requests_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = const [
      RiderFindScreen(),
      DriverOfferScreen(),
      MyRequestsScreen(),
      ProfileScreen(),                    // ← new bottom-right tab
    ];

    return Scaffold(
      appBar: gradientAppBar('Tareeqna'), // ← colorful header everywhere
      body: tabs[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Find'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Offer'),
          BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Requests'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'), // ← rightmost
        ],
      ),
    );
  }
}
