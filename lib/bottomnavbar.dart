import 'package:flutter/material.dart';
import 'package:musicallim_test/pages/homepage.dart'; // Song page
import 'package:musicallim_test/pages/playlist.dart'; // Playlist page
import 'package:musicallim_test/pages/profile.dart'; // Profile page
import 'package:musicallim_test/widgets/app_colors.dart'; // Import reusable color widget

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ResponsiveHomepage(), // Song page
    PlaylistPage(), // Playlist page
    const ProfilePage(), // Profile page
  ];

  void _onTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTab,
        backgroundColor: AppColors.background, // Set background color to dark background
        selectedItemColor: AppColors.accent, // Set selected item color to Spotify green
        unselectedItemColor: AppColors.iconColor, // Set unselected item color to light gray
        type: BottomNavigationBarType.fixed, // Keep icons and text visible
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Song',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play),
            label: 'Playlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: const TextStyle(
          color: AppColors.accent, // Set selected label color
        ),
        unselectedLabelStyle: const TextStyle(
          color: AppColors.textSecondary, // Set unselected label color
        ),
      ),
    );
  }
}
