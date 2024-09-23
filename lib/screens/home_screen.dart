import 'package:musicalim/controller/bottomnav_controller.dart';
import 'package:musicalim/menus/playlist.dart';
import 'package:musicalim/menus/home.dart';
import 'package:musicalim/menus/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController = 
    Get.put(BottomNavController());
    
    final List<Widget> menus = [const Home(), const Playlist(), const Profile()];

    return Obx(() {
      return Scaffold(
        body: menus[bottomNavController.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomNavController.selectedIndex.value,
          onTap: bottomNavController.changeindexMenu,
          
          items:const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.playlist_add_check_outlined),label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined),label: "Profile"),
        ]),
      );
    });
  }
}