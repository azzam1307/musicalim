import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioPlayerController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final RxList<Map<String, String>> _playlist = RxList<Map<String, String>>([]);
  final RxInt _currentSongIndex = (-1).obs;
  final Rx<PlayerState> _playerState = PlayerState.stopped.obs;
  final RxBool isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _playerState.value = state;
      isPlaying.value = state == PlayerState.playing;
    });

    _audioPlayer.onPlayerComplete.listen((event) async {
      await playNext();
    });
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }

  // Getters
  List<Map<String, String>> get playlist => _playlist;
  int get currentSongIndex => _currentSongIndex.value;
  PlayerState get playerState => _playerState.value;

  // New method to load full playlist
  void loadPlaylist(List<Map<String, String>> songs) {
    _playlist.clear();
    _playlist.addAll(songs);
  }

  // New method to play from specific index
  Future<void> playFromIndex(int index) async {
    if (index >= 0 && index < _playlist.length) {
      _currentSongIndex.value = index;
      await _playCurrentSong();
    }
  }

  Future<void> playNewSong(Map<String, String> song) async {
    int songIndex = _playlist.indexWhere((s) => 
      s['audioPath'] == song['audioPath'] && 
      s['title'] == song['title']
    );

    if (songIndex == -1) {
      // If song not in playlist, add it
      _playlist.add(song);
      songIndex = _playlist.length - 1;
    }

    _currentSongIndex.value = songIndex;
    await _playCurrentSong();
  }

  void addToPlaylist(Map<String, String> song) {
    if (!_playlist.any((s) => 
      s['audioPath'] == song['audioPath'] && 
      s['title'] == song['title']
    )) {
      _playlist.add(song);
    }

    if (_currentSongIndex.value == -1 && _playlist.isNotEmpty) {
      _currentSongIndex.value = _playlist.length - 1;
      _playCurrentSong();
    }
  }

  Future<void> togglePlay() async {
    if (_playerState.value == PlayerState.playing) {
      await pauseAudio();
    } else {
      await resumeAudio();
    }
  }

  Future<void> resumeAudio() async {
    await _audioPlayer.resume();
    isPlaying.value = true;
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    isPlaying.value = false;
  }

  Future<void> playNext() async {
    if (_playlist.isEmpty) return;

    if (_currentSongIndex.value < _playlist.length - 1) {
      _currentSongIndex.value++;
    } else {
      _currentSongIndex.value = 0;
    }
    await _playCurrentSong();
  }

  Future<void> playPrevious() async {
    if (_playlist.isEmpty) return;

    if (_currentSongIndex.value > 0) {
      _currentSongIndex.value--;
    } else {
      _currentSongIndex.value = _playlist.length - 1;
    }
    await _playCurrentSong();
  }

  Future<void> _playCurrentSong() async {
    if (_currentSongIndex.value >= 0 && _currentSongIndex.value < _playlist.length) {
      final audioPath = _playlist[_currentSongIndex.value]['audioPath']!;
      try {
        await _audioPlayer.stop();
        await _audioPlayer.setSource(AssetSource(audioPath));
        await _audioPlayer.resume();
        isPlaying.value = true;
      } catch (e) {
        print('Error playing current song: $e');
        isPlaying.value = false;
      }
    }
  }

  bool isCurrentlyPlaying() => isPlaying.value;
}