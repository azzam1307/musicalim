import 'package:flutter/material.dart';

class SongCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imageUrl;
  final VoidCallback onTap;

  const SongCard({
    Key? key,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl), // Gambar dari internet
        ),
        title: Text(title),
        subtitle: Text(artist),
        trailing: const Icon(Icons.play_arrow),
        onTap: onTap,  // Aksi ketika card di-tap
      ),
    );
  }
}
