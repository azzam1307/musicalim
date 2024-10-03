import 'package:flutter/material.dart';
import 'package:musicallim_test/pages/songlist.dart';
import 'package:provider/provider.dart';
import 'package:musicallim_test/controllers/playlist_controller.dart';

class PlaylistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showCreatePlaylistDialog(context);
            },
          ),
        ],
      ),
      body: Consumer<PlaylistController>(
        builder: (context, playlistController, child) {
          final folders = playlistController.playlistFolders;

          if (folders.isEmpty) {
            return const Center(child: Text('No playlist folders created'));
          }

          return ListView.builder(
            itemCount: folders.length,
            itemBuilder: (context, index) {
              final folderName = folders[index];
              final songs = playlistController.getSongsForFolder(folderName); // Ambil lagu di folder

              return GestureDetector(
                onTap: () {
                  // Navigasi ke SongListPage saat folder diklik
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongListPage(
                        folderName: folderName,
                        songs: songs,
                      ),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: const BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          folderName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text("Tap to open playlist folder"),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showCreatePlaylistDialog(BuildContext context) {
    String newPlaylistName = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Playlist Folder'),
          content: TextField(
            decoration: const InputDecoration(hintText: "Enter playlist name"),
            onChanged: (value) {
              newPlaylistName = value;
            },
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
                if (newPlaylistName.isNotEmpty) {
                  Provider.of<PlaylistController>(context, listen: false)
                      .addPlaylistFolder(newPlaylistName);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Create'),
            ),
          ],
        );  // Tanda kurung tutup untuk AlertDialog
      },
    );  // Tanda kurung tutup untuk showDialog
  }
}
