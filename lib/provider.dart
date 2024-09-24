import 'package:flutter/material.dart';
import 'package:musicallim_test/controllers/bottom_nav_controller.dart';
import 'package:musicallim_test/controllers/playlist_controller.dart';
import 'package:musicallim_test/pages/playlist.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlaylistController()),
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
      home: const BottomNavController(),  // Change to BottomNavController
      routes: {
        '/playlist': (context) =>  PlaylistPage(),
      },
    );
  }
}
