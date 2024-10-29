import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicallim_test/widgets/audio_player.dart';
import 'package:musicallim_test/widgets/song_card.dart';
import 'package:musicallim_test/controllers/audioplayer_controller.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:musicallim_test/widgets/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  _MobileHomePageState createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  List<Map<String, String>> songs = [];
  late AudioPlayerController _audioPlayerService;

  @override
  void initState() {
    super.initState();
    _audioPlayerService = Get.find<AudioPlayerController>();
    loadSongs();
  }

  Future<void> loadSongs() async {
    final String response = await rootBundle.loadString('assets/songs.json');
    final List<dynamic> data = json.decode(response);

    setState(() {
      songs = data.map<Map<String, String>>((item) {
        return {
          'title': item['title']?.toString() ?? '',
          'artist': item['artist']?.toString() ?? '',
          'imageUrl': item['imageUrl']?.toString() ?? '',
          'audioPath': item['audioPath']?.toString() ?? '',
        };
      }).toList();

      // Sort songs alphabetically
      songs.sort((a, b) => a['title']!.compareTo(b['title']!));

      // Load all songs to AudioPlayerController
      _audioPlayerService.loadPlaylist(songs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Song List',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: songs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Popular Songs (mobile)',
                      style: GoogleFonts.poppins(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.7, // Diubah menjadi 0.7
                    ),
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      return SongCard(
                        title: songs[index]['title']!,
                        artist: songs[index]['artist']!,
                        imageUrl: songs[index]['imageUrl']!,
                        onTap: () {
                          _audioPlayerService.playFromIndex(index);
                          Get.to(() =>
                              AudioPlayerWidget(currentSong: songs[index]));
                        },
                        textColor: AppColors.textPrimary,
                        cardColor: AppColors.cardBackground,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
