import 'package:flutter/material.dart';

class PlaylistController with ChangeNotifier {
  final List<Map<String, String>> _playlist = [];
  final List<String> _playlistFolders = [];

  List<Map<String, String>> get playlist => _playlist;
  List<String> get playlistFolders => _playlistFolders;

  void addToPlaylist(String title, String artist, String imageUrl, String audioPath) {
    _playlist.add({
      'title': title,
      'artist': artist,
      'imageUrl': imageUrl,
      'audioPath': audioPath,
    });
    notifyListeners();
  }

  void addPlaylistFolder(String folderName) {
    _playlistFolders.add(folderName);
    notifyListeners();
  }
}
