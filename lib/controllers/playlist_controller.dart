import 'package:get/get.dart';
import 'package:musicallim_test/services/database_service.dart';
import 'package:musicallim_test/models/playlist_model.dart';
import 'package:musicallim_test/models/song_model.dart';

class PlaylistController extends GetxController {
  var playlistFolders = <PlaylistModel>[].obs;
  var playlists = <int, List<SongModel>>{}.obs;
  final DatabaseService databaseService = DatabaseService();

  @override
  void onInit() {
    super.onInit();
    loadPlaylistsFromDb();
  }

  Future<void> loadPlaylistsFromDb() async {
    try {
      List<Map<String, dynamic>> dbPlaylists = await databaseService.getPlaylists();
      for (var playlist in dbPlaylists) {
        PlaylistModel playlistModel = PlaylistModel.fromMap(playlist);
        playlistFolders.add(playlistModel);

        if (playlistModel.id != null) {
          playlists[playlistModel.id!] = await loadSongsFromDb(playlistModel.id!);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load playlists: $e');
    }
  }

  Future<List<SongModel>> loadSongsFromDb(int playlistId) async {
    List<Map<String, dynamic>> dbSongs = await databaseService.getSongsForPlaylist(playlistId);
    return dbSongs.map((song) => SongModel.fromMap(song)).toList();
  }

  Future<void> addPlaylistFolder(String folderName) async {
    if (!playlistFolders.any((playlist) => playlist.name.toLowerCase() == folderName.toLowerCase())) {
      try {
        int playlistId = await databaseService.addPlaylist(folderName);
        PlaylistModel newPlaylist = PlaylistModel(id: playlistId, name: folderName);
        playlistFolders.add(newPlaylist);
        playlists[playlistId] = [];
      } catch (e) {
        Get.snackbar('Error', 'Failed to add playlist: $e');
      }
    } else {
      Get.snackbar('Warning', 'Playlist already exists.');
    }
  }

  Future<void> addToPlaylist(String folder, String title, String artist, String imageUrl, String audioPath) async {
    PlaylistModel? selectedPlaylist = playlistFolders.firstWhereOrNull((playlist) => playlist.name == folder);

    if (selectedPlaylist?.id != null) {
      SongModel newSong = SongModel(
        id: 0,
        title: title,
        artist: artist,
        imageUrl: imageUrl,
        audioPath: audioPath,
        playlistId: selectedPlaylist!.id!,
      );

      try {
        await databaseService.addSong(newSong);
        playlists[selectedPlaylist.id!]!.add(newSong);
      } catch (e) {
        Get.snackbar('Error', 'Failed to add song: $e');
      }
    } else {
      Get.snackbar('Error', 'Playlist not found');
    }
  }

  Future<void> deletePlaylist(int? playlistId) async {
    if (playlistId != null) {
      try {
        await databaseService.deletePlaylist(playlistId);
        playlistFolders.removeWhere((folder) => folder.id == playlistId);
        playlists.remove(playlistId);
        Get.snackbar('Success', 'Playlist deleted successfully.');
      } catch (e) {
        Get.snackbar('Error', 'Failed to delete playlist: $e');
      }
    } else {
      Get.snackbar('Error', 'Playlist ID is null. Cannot delete.');
    }
  }

  // Updated method to remove song from playlist
   Future<void> removeSongFromPlaylist({
    required int playlistId,
    required int songId,
  }) async {
    try {
      // Delete from database
      await databaseService.deleteSong(songId);
      
      // Update local state
      if (playlists.containsKey(playlistId)) {
        // Create new list without the removed song
        final updatedSongs = playlists[playlistId]!
            .where((song) => song.id != songId)
            .toList();
        
        // Update playlists using .value to trigger changes
        final newPlaylists = Map<int, List<SongModel>>.from(playlists);
        newPlaylists[playlistId] = updatedSongs;
        playlists.value = newPlaylists;

        // Update playlistFolders dengan model yang sesuai
        final index = playlistFolders.indexWhere((folder) => folder.id == playlistId);
        if (index != -1) {
          final updatedFolder = PlaylistModel(
            id: playlistId,
            name: playlistFolders[index].name,
          );
          
          final newFolders = List<PlaylistModel>.from(playlistFolders);
          newFolders[index] = updatedFolder;
          playlistFolders.value = newFolders;
        }
      }
      
      update(); // Force UI update
    } catch (e) {
      print('Error removing song from playlist: $e');
      Get.snackbar('Error', 'Failed to remove song from playlist');
    }
  }

  List<SongModel> getSongsFromPlaylist(int playlistId) {
    return playlists[playlistId] ?? [];
  }
}