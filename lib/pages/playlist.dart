import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/playlist_controller.dart';
import '../models/song_model.dart';
import '../pages/songinsidelist.dart';
import '../widgets/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistPage extends StatelessWidget {
  final PlaylistController _playlistController = Get.find<PlaylistController>();

  PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Playlist',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold, // Tebal seperti font Spotify
            fontSize: 24, // Ukuran font
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Obx(() {
        if (_playlistController.playlistFolders.isEmpty) {
          return const Center(child: Text('No playlists available.'));
        }

        return ListView.builder(
          itemCount: _playlistController.playlistFolders.length,
          itemBuilder: (context, index) {
            final playlist = _playlistController.playlistFolders[index];
            final List<SongModel> songs =
                _playlistController.playlists[playlist.id!] ?? [];

            return Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: ListTile(
                title: Text(playlist.name,
                    style: TextStyle(color: AppColors.textPrimary)),
                subtitle: Text('${songs.length} songs',
                    style: TextStyle(color: AppColors.textSecondary)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: AppColors.accent),
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Delete Playlist",
                      titleStyle: const TextStyle(
                        color: AppColors.textPrimary, // Set title color
                        fontWeight: FontWeight.bold, // Make the title bold
                      ),
                      middleText:
                          "Are you sure you want to delete this playlist?",
                      middleTextStyle: const TextStyle(
                          color:
                              AppColors.textSecondary), // Set middle text color
                      backgroundColor:
                          AppColors.cardBackground, // Set background color
                      textConfirm: "Delete",
                      confirmTextColor: Colors.white,
                      textCancel: "Cancel",
                      cancelTextColor:
                          AppColors.accent, // Set cancel button text color
                      buttonColor: AppColors.accent, // Set confirm button color
                      onConfirm: () async {
                        await _playlistController.deletePlaylist(playlist.id!);
                        Navigator.of(context).pop(); // Close dialog on confirm
                      },
                      onCancel: () {
                        Navigator.of(context).pop(); // Close dialog on cancel
                      },
                    );
                  },
                ),
                onTap: () {
                  Get.to(() => SongListPage(
                        playlistName: playlist.name,
                        playlistId: playlist.id!,
                      ));
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPlaylistDialog(context);
        },
        tooltip: 'Add New Playlist',
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
    );
  }

  void _showAddPlaylistDialog(BuildContext context) {
    final TextEditingController playlistNameController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              AppColors.cardBackground, // Set background color to match
          title: const Text(
            'Add New Playlist',
            style: TextStyle(color: AppColors.textPrimary), // Set title color
          ),
          content: TextField(
            controller: playlistNameController,
            style: const TextStyle(
                color: AppColors.textPrimary), // Set input text color
            decoration: InputDecoration(
              labelText: 'Playlist Name',
              labelStyle: const TextStyle(
                  color: AppColors.textSecondary), // Set label text color
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.textSecondary), // Border color
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.accent), // Focused border color
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog on cancel
              },
              child: const Text(
                'Cancel',
                style:
                    TextStyle(color: AppColors.accent), // Set button text color
              ),
            ),
            TextButton(
              onPressed: () async {
                if (playlistNameController.text.isNotEmpty) {
                  await _playlistController
                      .addPlaylistFolder(playlistNameController.text);
                  playlistNameController.clear();
                  Navigator.of(context)
                      .pop(); // Close dialog after adding playlist
                } else {
                  Get.snackbar('Warning', 'Playlist name cannot be empty');
                }
              },
              child: const Text(
                'Add',
                style:
                    TextStyle(color: AppColors.accent), // Set button text color
              ),
            ),
          ],
        );
      },
    );
  }
}
