import 'package:flutter/material.dart';

class PlaylistController with ChangeNotifier {
  // Untuk menyimpan lagu berdasarkan folder playlist
  final Map<String, List<Map<String, String>>> _playlistFolders = {}; // Folder => Daftar Lagu

  // Getter untuk folder playlist
  List<String> get playlistFolders => _playlistFolders.keys.toList();

  // Mendapatkan daftar lagu untuk folder tertentu
  List<Map<String, String>> getSongsForFolder(String folderName) {
    return _playlistFolders[folderName] ?? [];
  }

  // Menambahkan lagu ke folder playlist tertentu
  void addToPlaylist(String folderName, String title, String artist, String imageUrl, String audioPath) {
    if (title.isEmpty || artist.isEmpty || folderName.isEmpty) {
      throw Exception('Title, artist, and folder name cannot be empty'); // Validasi input
    }

    if (_playlistFolders.containsKey(folderName)) {
      _playlistFolders[folderName]?.add({
        'title': title,
        'artist': artist,
        'imageUrl': imageUrl,
        'audioPath': audioPath,
      });
    } else {
      // Jika folder belum ada, buat folder baru lalu tambahkan lagu
      _playlistFolders[folderName] = [
        {
          'title': title,
          'artist': artist,
          'imageUrl': imageUrl,
          'audioPath': audioPath,
        }
      ];
    }
    notifyListeners(); // Memberitahu semua listener bahwa data telah berubah
  }

  // Menambahkan folder playlist baru (tanpa lagu)
  void addPlaylistFolder(String folderName) {
    if (folderName.isEmpty) {
      throw Exception('Folder name cannot be empty'); // Validasi input
    }

    if (!_playlistFolders.containsKey(folderName)) {
      _playlistFolders[folderName] = []; // Inisialisasi folder dengan daftar lagu kosong
      notifyListeners(); // Memberitahu semua listener bahwa folder telah ditambahkan
    }
  }

  // Menghapus lagu dari folder playlist
  void removeSongFromFolder(String folderName, String title) {
    if (_playlistFolders.containsKey(folderName)) {
      _playlistFolders[folderName]?.removeWhere((song) => song['title'] == title);
      notifyListeners(); // Memberitahu listener bahwa data telah diubah
    }
  }

  // Menghapus folder playlist
  void removePlaylistFolder(String folderName) {
    if (_playlistFolders.containsKey(folderName)) {
      _playlistFolders.remove(folderName);
      notifyListeners(); // Memberitahu listener bahwa folder telah dihapus
    }
  }
}
