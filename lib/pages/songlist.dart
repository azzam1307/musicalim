import 'package:flutter/material.dart';
import 'package:musicallim_test/widgets/audio_player.dart'; // Import AudioPlayerWidget

class SongListPage extends StatefulWidget {
  final String folderName; // Nama folder
  final List<Map<String, String>> songs; // Daftar lagu dalam folder

  const SongListPage({
    Key? key,
    required this.folderName,
    required this.songs,
  }) : super(key: key);

  @override
  _SongListPageState createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  String? _currentPlayingAudioPath; // Untuk menyimpan lagu yang sedang diputar
  String _currentTitle = '';
  String _currentArtist = '';
  String _currentImageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folderName), // Menampilkan nama folder
      ),
      body: Column(
        children: [
          // Widget Audio Player
          if (_currentPlayingAudioPath != null)
            AudioPlayerWidget(
              audioPath: _currentPlayingAudioPath!,
              title: _currentTitle,
              artist: _currentArtist,
              imageUrl: _currentImageUrl,
            ),
          Expanded(
            child: widget.songs.isEmpty
                ? const Center(child: Text('No songs available in this folder'))
                : ListView.builder(
                    itemCount: widget.songs.length,
                    itemBuilder: (context, index) {
                      final song = widget.songs[index];
                      return ListTile(
                        title: Text(song['title'] ?? 'Unknown Title'),
                        subtitle: Text(song['artist'] ?? 'Unknown Artist'),
                        leading: song['imageUrl'] != null
                            ? Image.network(song['imageUrl']!)
                            : null,
                        onTap: () {
                          _playAudio(
                            song['title'] ?? 'Unknown Title',
                            song['artist'] ?? 'Unknown Artist',
                            song['imageUrl'] ?? '',
                            song['audioPath'] ?? '', // Pastikan ada audioPath
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _playAudio(
      String title, String artist, String imageUrl, String audioPath) {
    setState(() {
      _currentPlayingAudioPath = audioPath; // Set audio path untuk diputar
      _currentTitle = title;
      _currentArtist = artist;
      _currentImageUrl = imageUrl;
    });
  }
}
