import 'package:flutter/material.dart';
import 'package:musicallim_test/widgets/app_colors.dart'; // Import reusable color widget

class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTab;

  const BottomNavBarWidget({
    Key? key,
    required this.currentIndex,
    required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTab,
      backgroundColor: AppColors.background, // Set background color to dark background
      selectedItemColor: AppColors.accent, // Set selected item color to Spotify green
      unselectedItemColor: AppColors.iconColor, // Set unselected item color to light gray
      type: BottomNavigationBarType.fixed, // Ensures icons stay visible with text
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
        color: AppColors.accent, // Set selected label text color
      ),
      unselectedLabelStyle: const TextStyle(
        color: AppColors.textSecondary, // Set unselected label text color
      ),
    );
  }
}
