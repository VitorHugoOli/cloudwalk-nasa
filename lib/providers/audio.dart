import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  late AudioPlayer _audioPlayer;
  SharedPreferences? prefs;

  final List<String> songs = [
    'songs/experience.m4a',
    'songs/claire_de_lune.mp3',
    // Add more songs here
  ];
  int currentSongIndex = 0;

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    _audioPlayer = AudioPlayer();
    _audioPlayer.stop();

    AudioPlayer.global.setAudioContext(const AudioContext(
      android: AudioContextAndroid(),
      iOS: AudioContextIOS(),
    ));

    bool? isAudioOn = prefs!.getBool('isAudioOn');
    isAudioOn ??= true;
    if (isAudioOn) play();
    _audioPlayer.onPlayerComplete.listen((_) {
      _playNext();
    });
  }

  void _playNext() {
    currentSongIndex = (currentSongIndex + 1) % songs.length;
    _audioPlayer.play(AssetSource(songs[currentSongIndex]));
  }

  get player => _audioPlayer;

  void play() => _audioPlayer.play(AssetSource(songs[currentSongIndex]));

  void stop() {
    if (_audioPlayer.state == PlayerState.playing) _audioPlayer.stop();
  }

  void pause() {
    if (_audioPlayer.state == PlayerState.playing) _audioPlayer.pause();
  }

  void resume() {
    if (_audioPlayer.state == PlayerState.paused) _audioPlayer.resume();
  }

  void previous() {
    currentSongIndex = (currentSongIndex - 1) % songs.length;
    _audioPlayer.play(AssetSource(songs[currentSongIndex]));
  }

  void next() {
    _playNext();
  }

  bool get toggle => prefs!.getBool('isAudioOn') ?? true;

  void toggleAudio() {
    bool isAudioOn = prefs!.getBool('isAudioOn') ?? true;
    isAudioOn = !isAudioOn;
    prefs!.setBool('isAudioOn', isAudioOn);
    if (isAudioOn) {
      play();
    } else {
      stop();
    }
  }
}
