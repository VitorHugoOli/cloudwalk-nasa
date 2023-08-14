import 'package:cloudwalknasa/main.dart';
import 'package:flutter/material.dart';

class Tutorial extends StatelessWidget {
  const Tutorial({Key? key}) : super(key: key);

  static Future<void> show() => showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => const Tutorial(),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tutorial'),

      content: SingleChildScrollView(
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: const <TextSpan>[
              TextSpan(
                  text: "Welcome to the NASA APOD app!",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "\n\nThis app is a gallery of NASA's "),
              TextSpan(
                  text: "Astronomy Picture of the Day",
                  style: TextStyle(fontStyle: FontStyle.italic)),
              TextSpan(
                text: """ (APOD).\n
You can view the featured image of the day or browse through the gallery of stunning space visuals.\n
Here are some helpful tips to enhance your experience:\n
- To access the bottom navigation bar, simply swipe up from the bottom of the screen.\n
- When viewing an image in Full Mode, turn your device to landscape mode to see the entire image without any cropping.\n
- Turn up the volume, immerse yourself in the music, and embark on a journey through the cosmos!\n
          """,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
