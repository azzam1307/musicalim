import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:musicallim_test/models/song_model.dart'; // Import model SongModel
import 'package:musicallim_test/models/user_model.dart'; // Import model UserModel

class DatabaseService {
  static Database? _db;

  
  Future<Database?> get db async {
    _db ??= await initDB();
    return _db;
  }

  
  Future<Database> initDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'music_database.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        
        await db.execute('''
          CREATE TABLE playlists(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT
          )
        ''');

       
        await db.execute('''
          CREATE TABLE songs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            artist TEXT,
            imageUrl TEXT,
            audioPath TEXT,
            playlistId INTEGER,
            FOREIGN KEY(playlistId) REFERENCES playlists(id)
          )
        ''');

       
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
       
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE users(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT
            )
          ''');
        }
      },
    );
  }

  // Fungsi untuk menghapus database (hanya digunakan untuk pengembangan/testing)
  Future<void> deleteExistingDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'music_database.db');
    await deleteDatabase(path); // Memanggil fungsi deleteDatabase dari sqflite
  }

  // ---------------- PLAYLIST FUNCTIONS ----------------

  // Menambahkan playlist ke dalam database
  Future<int> addPlaylist(String name) async {
    var dbClient = await db;
    return await dbClient!.insert('playlists', {'name': name});
  }

  // Menambahkan lagu ke playlist tertentu
  Future<int> addSong(SongModel song) async {
    var dbClient = await db;
    return await dbClient!.insert('songs', song.toMap()); // Menggunakan method toMap dari SongModel
  }

  // Mengambil semua playlist
  Future<List<Map<String, dynamic>>> getPlaylists() async {
    var dbClient = await db;
    return await dbClient!.query('playlists');
  }

  // Mengambil semua lagu untuk playlist tertentu
  Future<List<Map<String, dynamic>>> getSongsForPlaylist(int playlistId) async {
    var dbClient = await db;
    return await dbClient!.query(
      'songs',
      where: 'playlistId = ?',
      whereArgs: [playlistId],
    );
  }

  // Menghapus playlist dari database
  Future<int> deletePlaylist(int playlistId) async {
    var dbClient = await db;
    return await dbClient!.delete('playlists', where: 'id = ?', whereArgs: [playlistId]);
  }

  // Menghapus lagu dari database
  Future<int> deleteSong(int songId) async {
    var dbClient = await db;
    return await dbClient!.delete('songs', where: 'id = ?', whereArgs: [songId]);
  }

  // ---------------- USER FUNCTIONS ----------------

  // Menambahkan user ke dalam database
  Future<int> addUser(UserModel user) async {
    var dbClient = await db;
    return await dbClient!.insert('users', user.toMap()); // Menggunakan method toMap dari UserModel
  }

  // Mengambil user dari database (hanya satu user dalam aplikasi)
  Future<UserModel?> getUser() async {
    var dbClient = await db;
    List<Map<String, dynamic>> users = await dbClient!.query('users');

    if (users.isNotEmpty) {
      return UserModel.fromMap(users.first); // Mengambil user pertama dari list
    }
    return null; // Jika tidak ada user yang ditemukan
  }

  // Update user di dalam database
  Future<int> updateUser(UserModel user) async {
    var dbClient = await db;
    return await dbClient!.update(
      'users',
      user.toMap(),
      where: 'id = ?', // Update user berdasarkan id
      whereArgs: [user.id],
    );
  }

  // Menghapus user dari database
  Future<int> deleteUser(int userId) async {
    var dbClient = await db;
    return await dbClient!.delete('users', where: 'id = ?', whereArgs: [userId]);
  }
}
