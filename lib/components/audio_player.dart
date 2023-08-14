import 'package:cloudwalknasa/providers/audio.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

extension on String{
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

String extractSongName(String input) {
  // Defining a regex pattern to match the path of the song
  final pattern = RegExp(r'path: songs\/(.*?)\)');
  final match = pattern.firstMatch(input);

  // If match found, return the song name
  if (match != null && match.groupCount >= 1) {
    return match.group(1)!.split('.')[0].capitalize();
  }

  // Return an empty string if no match found
  return "";
}

class AudioPlayerWidget extends StatefulWidget {
  final AudioPlayer player;

  const AudioPlayerWidget(this.player, {super.key});

  @override
  State<StatefulWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
    with SingleTickerProviderStateMixin {
  PlayerState playerState = PlayerState.stopped;
  late AnimationController _animationController;
  int speedIndex = 1;
  final List<double> speeds = [0.5, 1, 1.5, 2];
  Duration duration = const Duration();
  Duration position = const Duration();
  String songName = '';

  @override
  void initState() {
    super.initState();

    widget.player.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        playerState = state;
      });
      if (state == PlayerState.playing) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });

    widget.player.onDurationChanged.listen(
      (Duration d) => setState(() => duration = d),
    );

    widget.player.onPositionChanged.listen(
      (Duration p) => setState(() => position = p),
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // check if the player is already playing
    widget.player.state == PlayerState.playing
        ? _animationController.forward()
        : _animationController.reverse();

    widget.player.getDuration().then((value) => setState(() {
          duration = value ?? const Duration();
        }));

    widget.player.getCurrentPosition().then((value) => setState(() {
          position = value ?? const Duration();
        }));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void changeSpeed() async {
    setState(() => speedIndex = (speedIndex + 1) % speeds.length);
    await widget.player.setPlaybackRate(speeds[speedIndex]);
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(extractSongName(widget.player.source.toString())),
        Row(
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: duration.inMilliseconds > 0
                      ? position.inMilliseconds / duration.inMilliseconds
                      : 0,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 50),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  playerState == PlayerState.stopped
                      ? formatDuration(duration)
                      : formatDuration(duration - position),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Previous button
            IconButton(
              icon: const Icon(Icons.skip_previous),
              onPressed: () async {
                AudioManager().previous();
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay_10),
              onPressed: () async {
                Duration? currentPosition =
                    await widget.player.getCurrentPosition();
                if (currentPosition == null) return;
                await widget.player.seek(
                    currentPosition + const Duration(milliseconds: 10000));
              },
            ),
            IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: _animationController,
              ),
              onPressed: () async {
                if (playerState == PlayerState.playing) {
                  await widget.player.pause();
                } else {
                  await widget.player.resume();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.forward_10),
              onPressed: () async {
                Duration? currentPosition =
                    await widget.player.getCurrentPosition();
                if (currentPosition == null) return;
                await widget.player.seek(
                    currentPosition + const Duration(milliseconds: 10000));
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: () async {
                AudioManager().next();
              },
            ),
            TextButton(
              onPressed: changeSpeed,
              child: Text('${speeds[speedIndex]}x'),
            ),
          ],
        ),
      ],
    );
  }
}
