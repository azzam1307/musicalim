import 'package:flutter/material.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist Page'),
      ),
      body: const Center(
        child: Text('Playlist Page Content'),
      ),
    );
  }
}
