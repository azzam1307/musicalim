import 'package:flutter/material.dart';
import 'package:musicallim_test/controllers/bottom_nav_controller.dart';
import 'package:musicallim_test/controllers/playlist_controller.dart';
import 'package:musicallim_test/pages/playlist.dart';
import 'package:musicallim_test/pages/profile.dart';
import 'package:musicallim_test/pages/songlist.dart'; // Import halaman untuk navigasi ke daftar lagu
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlaylistController()),  // Provider untuk PlaylistController
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
      home: const BottomNavController(),  // Navigasi menggunakan BottomNavController
      routes: {
        '/playlist': (context) => PlaylistPage(),  // Route untuk PlaylistPage
        // Mengubah rute untuk SongListPage agar menerima argumen
        '/songlist': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return SongListPage(
            folderName: args['folderName'], 
            songs: args['songs'],
          );
        },  
      },
    );
  }
}
