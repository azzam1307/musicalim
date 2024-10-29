class SongModel {
  int id;
  String title;
  String artist;
  String imageUrl;
  String audioPath;
  int playlistId;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.audioPath,
    required this.playlistId,
  });

  // Mengonversi SongModel menjadi Map untuk disimpan ke database
  Map<String, dynamic> toMap() {
    return {
      'id': id == 0
          ? null
          : id, // Biarkan null jika id = 0 agar autoincrement bekerja
      'title': title,
      'artist': artist,
      'imageUrl': imageUrl,
      'audioPath': audioPath,
      'playlistId': playlistId,
    };
  }

  // Tambahkan method ini di SongModel
  Map<String, String> toAudioMap() {
    return {
      'title': title,
      'artist': artist,
      'imageUrl': imageUrl,
      'audioPath': audioPath,
    };
  }

  // Membuat SongModel dari Map (berguna saat mengambil data dari database)
  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      imageUrl: map['imageUrl'],
      audioPath: map['audioPath'],
      playlistId: map['playlistId'],
    );
  }
}
