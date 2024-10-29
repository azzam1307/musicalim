import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/playlist_controller.dart';
import 'controllers/audioplayer_controller.dart'; // Import AudioPlayerService
import 'pages/startpage.dart'; // Import StartPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Music Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(
            PlaylistController()); // Ensure PlaylistController is added here
        Get.put(AudioPlayerController()); // Bind AudioPlayerService here
      }),
      home: const StartPage(), // StartPage sebagai halaman pertama
    );
  }
}
