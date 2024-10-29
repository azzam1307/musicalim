import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicallim_test/controllers/audioplayer_controller.dart';
import 'package:musicallim_test/controllers/playlist_controller.dart';
import 'package:musicallim_test/widgets/song_card.dart';
import 'package:musicallim_test/widgets/audio_player.dart';
import 'package:musicallim_test/models/song_model.dart';
import 'package:musicallim_test/widgets/app_colors.dart'; // Tambahkan import ini

class SongListPage extends StatelessWidget {
  final int playlistId;
  final String playlistName;

  SongListPage({required this.playlistId, required this.playlistName});

  final PlaylistController _playlistController = Get.find<PlaylistController>();
  final AudioPlayerController _audioPlayerController = Get.find<AudioPlayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Menggunakan background color dari AppColors
      appBar: AppBar(
        title: Text(
          playlistName,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.iconColor), // Warna untuk back button
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(() {
          List<SongModel> songs = _playlistController.getSongsFromPlaylist(playlistId);
          if (songs.isEmpty) {
            return const Center(
              child: Text(
                'No songs in this playlist',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return SongCard(
                title: song.title,
                artist: song.artist,
                imageUrl: song.imageUrl,
                textColor: AppColors.textPrimary,
                cardColor: AppColors.cardBackground,
                onTap: () {
                  _audioPlayerController.loadPlaylist(
                    songs.map((s) => s.toAudioMap()).toList()
                  );
                  _audioPlayerController.playFromIndex(index);
                  Get.to(
                    () => AudioPlayerWidget(currentSong: song.toAudioMap()),
                    transition: Transition.downToUp, // Menambahkan animasi transisi
                  );
                },
                onDelete: () async {
                  if (song.id != null) {
                    await _playlistController.removeSongFromPlaylist(
                      playlistId: playlistId,
                      songId: song.id,
                    );
                    Get.snackbar(
                      'Success',
                      'Song removed from playlist',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primary.withOpacity(0.7),
                      colorText: AppColors.textPrimary,
                      margin: const EdgeInsets.all(8),
                      borderRadius: 8,
                    );
                  }
                },
              );
            },
          );
        }),
      ),
    );
  }
}