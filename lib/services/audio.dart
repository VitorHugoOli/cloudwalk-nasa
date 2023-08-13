import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  late AudioPlayer _audioPlayer;
  late AudioCache _audioCache;

  final List<String> songs = [
    'claire_de_lune.mp3',
    'experience.mp3',
    // Add more songs here
  ];
  int currentSongIndex = 0;

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal() {
    _initialize();
  }

  void _initialize() {
    _audioPlayer = AudioPlayer();
    _audioCache = AudioCache(prefix: 'assets/songs/', fixedPlayer: _audioPlayer);
    _audioPlayer.onPlayerCompletion.listen((_) {
      _playNext();
    });
  }

  void clearAndReset() {
    stop();
    _initialize();
    currentSongIndex = 0; // Reset the song index if necessary
  }


  void _playNext() {
    currentSongIndex = (currentSongIndex + 1) % songs.length;
    _audioCache.play(songs[currentSongIndex]);
  }

  void play() {
    // avoid playing concorrently songs
    _audioCache.play(songs[currentSongIndex]);
  }

  void stop() {
    _audioPlayer.stop();
  }
}
