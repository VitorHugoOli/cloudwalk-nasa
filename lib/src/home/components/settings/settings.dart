import 'package:cloudwalknasa/components/audio_player.dart';
import 'package:cloudwalknasa/providers/audio.dart';
import 'package:cloudwalknasa/src/home/components/tutorial.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Direction { VERTICAL, HORIZONTAL }

class SettingItem {
  final String title;
  final Widget widget;
  final Direction direction;

  const SettingItem({
    required this.title,
    required this.widget,
    this.direction = Direction.VERTICAL,
  });
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late List<SettingItem> settings;
  SharedPreferences? prefs;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    settings = [
      SettingItem(
        title: 'Audio Controller',
        widget: AudioPlayerWidget(AudioManager().player),
        direction: Direction.VERTICAL,
      ),
      SettingItem(
        title: 'Toggle - Audio On/Off',
        widget: Switch(
          value: AudioManager().toggle,
          onChanged: (value) {
            AudioManager().toggleAudio();
            setState(() {});
          },
        ),
        direction: Direction.HORIZONTAL,
      ),
      SettingItem(
        title: 'Toggle - Reactive splash screen',
        widget: Switch(
          value: prefs?.getBool('isShowingSplash') ?? true,
          onChanged: (value) {
            prefs?.setBool('isShowingSplash', value);
            setState(() {});
          },
        ),
        direction: Direction.HORIZONTAL,
      ),
      SettingItem(
        title: 'Tutorial',
        widget: OutlinedButton(
          onPressed: () => Tutorial.show(),
          child: const Text('Show Tutorial'),
        ),
        direction: Direction.HORIZONTAL,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              itemCount: settings.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final item = settings[index];
                var children = [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3A3A3A),
                    ),
                  ),
                  item.widget,
                ];
                if (item.direction == Direction.HORIZONTAL) {
                  children = [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: children,
                    ),
                  ];
                } else {
                  children = [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    ),
                  ];
                }
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
