import 'package:flutter/material.dart';
import 'package:musicallim_test/widgets/audio_player.dart';  // Import halaman AudioPlayerPage
import 'package:musicallim_test/widgets/song_card.dart';  // Import widget SongCard

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Song Page'),
      ),
      body: ListView(
        children: [
          // Menggunakan SongCard untuk menampilkan lagu
          SongCard(
            title: 'Why',
            artist: 'Bazzi',
            imageUrl: 'https://i.scdn.co/image/ab67616d0000b273f9f2d43ff44bdfbe8c556f8d',  // Gambar dari URL
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AudioPlayerPage(
                    title: 'Why',
                    artist: 'Bazzi',
                    imageUrl: 'https://i.scdn.co/image/ab67616d0000b273f9f2d43ff44bdfbe8c556f8d',
                    audioPath: 'assets/bazzi.mp3',  // Path ke audio file di assets
                  ),
                ),
              );
            },
          ),
          SongCard(
            title: 'Love Nwantiti',
            artist: 'Ckay',
            imageUrl: 'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',  // Gambar dari URL
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AudioPlayerPage(
                    title: 'Love Nwantiti',
                    artist: 'Ckay',
                    imageUrl: 'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',
                    audioPath: 'assets/ckay.mp3',  // Path ke file audio
                  ),
                ),
              );
            },
          ),
          SongCard(
            title: 'Love Nwantiti',
            artist: 'Ckay',
            imageUrl: 'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',  // Gambar dari URL
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AudioPlayerPage(
                    title: 'Love Nwantiti',
                    artist: 'Ckay',
                    imageUrl: 'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',
                    audioPath: 'assets/ckay.mp3',  // Path ke file audio
                  ),
                ),
              );
            },
          ),
          SongCard(
            title: 'Love Nwantiti',
            artist: 'Ckay',
            imageUrl: 'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',  // Gambar dari URL
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AudioPlayerPage(
                    title: 'Love Nwantiti',
                    artist: 'Ckay',
                    imageUrl: 'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',
                    audioPath: 'assets/ckay.mp3',  // Path ke file audio
                  ),
                ),
              );
            },
          ),
          SongCard(
            title: 'Love Nwantiti',
            artist: 'Ckay',
            imageUrl: 'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',  // Gambar dari URL
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AudioPlayerPage(
                    title: 'Love Nwantiti',
                    artist: 'Ckay',
                    imageUrl: 'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',
                    audioPath: 'assets/ckay.mp3',  // Path ke file audio
                  ),
                ),
              );
            },
          ),
          SongCard(
            title: 'Love Nwantiti',
            artist: 'Ckay',
            imageUrl: 'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',  // Gambar dari URL
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AudioPlayerPage(
                    title: 'Love Nwantiti',
                    artist: 'Ckay',
                    imageUrl: 'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',
                    audioPath: 'assets/ckay.mp3',  // Path ke file audio
                  ),
                ),
              );
            },
          ),
          SongCard(
            title: 'Love Nwantiti',
            artist: 'Ckay',
            imageUrl: 'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',  // Gambar dari URL
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AudioPlayerPage(
                    title: 'Love Nwantiti',
                    artist: 'Ckay',
                    imageUrl: 'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',
                    audioPath: 'assets/ckay.mp3',  // Path ke file audio
                  ),
                ),
              );
            },
          ),
          // Tambahkan SongCard lainnya sesuai kebutuhan
        ],
      ),
    );
  }
}
