import 'package:flutter/material.dart';
import 'package:musicallim_test/widgets/audio_player.dart';
import 'package:musicallim_test/widgets/song_card.dart';
import 'package:provider/provider.dart';
import 'package:musicallim_test/controllers/playlist_controller.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Song List'),
      ),
      body: ListView(
        children: [
          SongCard(
            title: 'Why',
            artist: 'Bazzi',
            imageUrl:
                'https://i.scdn.co/image/ab67616d0000b273f9f2d43ff44bdfbe8c556f8d',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AudioPlayerWidget(
                    title: 'Why',
                    artist: 'Bazzi',
                    imageUrl:
                        'https://i.scdn.co/image/ab67616d0000b273f9f2d43ff44bdfbe8c556f8d',
                    audioPath: 'bazzi.mp3', // Correct path
                  ),
                ),
              );
            },
            onAddToPlaylist: () {
              _showAddToPlaylistDialog(
                context,
                'Why',
                'Bazzi',
                'https://i.scdn.co/image/ab67616d0000b273f9f2d43ff44bdfbe8c556f8d',
                'bazzi.mp3',
              );
            },
          ),
          SongCard(
            title: 'Love Nwantiti',
            artist: 'Ckay',
            imageUrl:
                'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AudioPlayerWidget(
                    title: 'Love Nwantiti',
                    artist: 'Ckay',
                    imageUrl:
                        'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',
                    audioPath: 'ckay.mp3', // Correct path
                  ),
                ),
              );
            },
            onAddToPlaylist: () {
              _showAddToPlaylistDialog(
                context,
                'Love Nwantiti',
                'Ckay',
                'https://i1.sndcdn.com/artworks-29yIyNIypDmFztBs-Bqu3zQ-t500x500.png',
                'ckay.mp3',
              );
            },
          ),
          SongCard(
            title: 'Gata Only',
            artist: 'Floyymenor',
            imageUrl:
                'https://i.scdn.co/image/ab67616d0000b273c4583f3ad76630879a75450a',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AudioPlayerWidget(
                    title: 'Gata Only',
                    artist: 'Floyymenor',
                    imageUrl:
                        'https://i.scdn.co/image/ab67616d0000b273c4583f3ad76630879a75450a',
                    audioPath: 'gata.mp3', // Correct path
                  ),
                ),
              );
            },
            onAddToPlaylist: () {
              _showAddToPlaylistDialog(
                context,
                'Gata Only',
                'Floyymenor',
                'https://i.scdn.co/image/ab67616d0000b273c4583f3ad76630879a75450a',
                'gata.mp3',
              );
            },
          ),
          SongCard(
            title: 'Peligrosa',
            artist: 'Floyymenor',
            imageUrl:
                'https://i.scdn.co/image/ab67616d0000b273f78c5533df63ff4c3e86f64b',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AudioPlayerWidget(
                    title: 'Peligrosa',
                    artist: 'Floyymenor',
                    imageUrl:
                        'https://i.scdn.co/image/ab67616d0000b273f78c5533df63ff4c3e86f64b',
                    audioPath: 'peligrosa.mp3', // Correct path
                  ),
                ),
              );
            },
            onAddToPlaylist: () {
              _showAddToPlaylistDialog(
                context,
                'Peligrosa',
                'Floyymenor',
                'https://i.scdn.co/image/ab67616d0000b273f78c5533df63ff4c3e86f64b',
                'gata.mp3',
              );
            },
          ),
          SongCard(
            title: 'Ransom',
            artist: 'Lil Tecca',
            imageUrl:
                'https://i.scdn.co/image/ab67616d0000b273bd69bbde4aeee723d6d08058',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AudioPlayerWidget(
                    title: 'Ransom',
                    artist: 'Lil Teccar',
                    imageUrl:
                        'https://i.scdn.co/image/ab67616d0000b273bd69bbde4aeee723d6d08058',
                    audioPath: 'ransom.mp3', // Correct path
                  ),
                ),
              );
            },
            onAddToPlaylist: () {
              _showAddToPlaylistDialog(
                context,
                'Ransom',
                'Lil Tecca',
                'https://i.scdn.co/image/ab67616d0000b273bd69bbde4aeee723d6d08058',
                'gata.mp3',
              );
            },
          ),
        ],
      ),
    );
  }

  // Function to show a dialog where user can select which playlist to add song to
  void _showAddToPlaylistDialog(
    BuildContext context,
    String title,
    String artist,
    String imageUrl,
    String audioPath,
  ) {
    final playlistController =
        Provider.of<PlaylistController>(context, listen: false);

    if (playlistController.playlistFolders.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No playlist folders available. Create one first!')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String selectedPlaylist = playlistController.playlistFolders.first;

        return AlertDialog(
          title: const Text('Add to Playlist'),
          content: DropdownButton<String>(
            value: selectedPlaylist,
            onChanged: (String? newValue) {
              if (newValue != null) {
                selectedPlaylist = newValue;
              }
            },
            items: playlistController.playlistFolders
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the song to the selected playlist
                playlistController.addToPlaylist(
                  title,
                  artist,
                  imageUrl,
                  audioPath,
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$title added to $selectedPlaylist!')),
                );
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
