import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioPath;
  final String title;
  final String artist;
  final String imageUrl;

  const AudioPlayerWidget({
    Key? key,
    required this.audioPath,
    required this.title,
    required this.artist,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  void _playAudio() async {
    await _audioPlayer.play(AssetSource(widget.audioPath));
    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  void _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Center(
    child: Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Adjust padding inside the card
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 28, // Adjusted the title size
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Center the text
            ),
            const SizedBox(height: 10),
            Text(
              widget.artist,
              style: const TextStyle(
                fontSize: 18, // Adjusted the artist size
                color: Colors.grey, // Make the artist name color subtle
              ),
              textAlign: TextAlign.center, // Center the text
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0), // Round the image corners
              child: Image.network(
                widget.imageUrl,
                height: 200, // Set a fixed size for the image
                width: 200,
                fit: BoxFit.cover, // Cover the card area neatly
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                    size: 64,
                    color: Colors.blue, // Highlight the button in color
                  ),
                  onPressed: () {
                    if (_isPlaying) {
                      _pauseAudio();
                    } else {
                      _playAudio();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.stop_circle,
                    size: 64,
                    color: Colors.red, // Make stop button red
                  ),
                  onPressed: _stopAudio,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
}