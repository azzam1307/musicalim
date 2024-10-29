import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicallim_test/controllers/audioplayer_controller.dart';
import 'package:musicallim_test/controllers/playlist_controller.dart';

class AudioPlayerWidget extends StatefulWidget {
  final Map<String, String> currentSong;

  const AudioPlayerWidget({super.key, required this.currentSong});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayerController _audioPlayerService;
  late PlaylistController _playlistController;
  final RxMap<String, String> _currentSong = <String, String>{}.obs;

  @override
  void initState() {
    super.initState();
    _audioPlayerService = Get.find<AudioPlayerController>();
    _playlistController = Get.find<PlaylistController>();
    _currentSong.value = widget.currentSong;

    // Initialize the song
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCurrentSong();
    });
  }

  void _updateCurrentSong() {
    if (_audioPlayerService.playlist.isNotEmpty) {
      _currentSong.value = _audioPlayerService.playlist[_audioPlayerService.currentSongIndex];
    }
  }

  void _showPlaylistSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Playlist'),
          content: Obx(() {
            if (_playlistController.playlistFolders.isEmpty) {
              return const Text('No playlists available. Create one first.');
            }
            return SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _playlistController.playlistFolders.length,
                itemBuilder: (context, index) {
                  final playlist = _playlistController.playlistFolders[index];
                  return ListTile(
                    title: Text(playlist.name),
                    onTap: () async {
                      Navigator.of(context).pop();
                      await _addToPlaylist(playlist.name);
                      Get.snackbar(
                        'Success',
                        'Added to ${playlist.name}',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green.withOpacity(0.7),
                        colorText: Colors.white,
                      );
                    },
                  );
                },
              ),
            );
          }),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('New Playlist'),
              onPressed: () {
                Navigator.of(context).pop();
                _showCreatePlaylistDialog();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCreatePlaylistDialog() {
    final TextEditingController nameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create New Playlist'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Enter playlist name'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Create'),
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  await _playlistController.addPlaylistFolder(nameController.text);
                  Navigator.of(context).pop();
                  _showPlaylistSelectionDialog();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addToPlaylist(String playlistName) async {
    await _playlistController.addToPlaylist(
      playlistName,
      _currentSong['title'] ?? '',
      _currentSong['artist'] ?? '',
      _currentSong['imageUrl'] ?? '',
      _currentSong['audioPath'] ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              final currentSong = _audioPlayerService.playlist.isNotEmpty
                  ? _audioPlayerService.playlist[_audioPlayerService.currentSongIndex]
                  : _currentSong.value;
              
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(currentSong['imageUrl'] ?? ''),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    currentSong['title'] ?? 'Unknown Title',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentSong['artist'] ?? 'Unknown Artist',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous, size: 48, color: Colors.white),
                  onPressed: () => _audioPlayerService.playPrevious(),
                ),
                const SizedBox(width: 32),
                Obx(() => IconButton(
                  icon: Icon(
                    _audioPlayerService.isCurrentlyPlaying()
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    size: 64,
                    color: Colors.white,
                  ),
                  onPressed: () => _audioPlayerService.togglePlay(),
                )),
                const SizedBox(width: 32),
                IconButton(
                  icon: const Icon(Icons.skip_next, size: 48, color: Colors.white),
                  onPressed: () => _audioPlayerService.playNext(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            IconButton(
              icon: const Icon(Icons.playlist_add, size: 48, color: Colors.white),
              onPressed: _showPlaylistSelectionDialog,
              tooltip: 'Add to Playlist',
            ),
          ],
        ),
      ),
    );
  }
}