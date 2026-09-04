import 'package:flutter/material.dart';
import 'package:travel_app/features/info/screen/info_screen.dart';
import 'package:travel_app/features/world_explorer/screen/world_explorer_screen.dart';

import '../home/screen/home_screen.dart';
import '../trips/screen/trips_screen.dart';
import '../travelnotes/screen/travel_note.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int selectedIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const TripsScreen(),
    const WorldExplorerScreen(),
    const TravelNotesScreen(),
    const InfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.flight),
            label: 'Trips',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.perm_device_info_rounded),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}