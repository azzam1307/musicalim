import 'package:flutter/material.dart';
import 'package:musicallim_test/controllers/playlist_controller.dart';
import 'package:provider/provider.dart';
import 'controllers/bottom_nav_controller.dart'; // Import your BottomNavController

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlaylistController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavController(), // Use BottomNavController as the home
    );
  }
}
