import 'package:cloudwalknasa/main.dart';
import 'package:cloudwalknasa/services/audio.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;
  final String textToDisplay = 'NASA Gallery'.toUpperCase();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: textToDisplay.length~/2),
    );

    _animations = List.generate(
      textToDisplay.length,
          (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index / textToDisplay.length,
            (index + 1) / textToDisplay.length,
            curve: Curves.easeIn,
          ),
        ),
      ),
    );

    AudioManager().play(); // Start playing music

    _controller.forward();

    // Navigate to the next page after 6 seconds + the duration of the animation
    Future.delayed(Duration(seconds: 6 + textToDisplay.length), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _controller,
              child: Image.asset('assets/nasa-logo.png'),
            ),
            const SizedBox(height: 20),
            _animatedText(0, 4), // NASA
            _animatedText(5, textToDisplay.length), // Gallery
          ],
        ),
      ),
    );
  }

  Widget _animatedText(int start, int end) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _animations
          .sublist(start, end)
          .asMap()
          .entries
          .map((entry) => _animatedLetter(entry.key + start))
          .toList(),
    );
  }

  Widget _animatedLetter(int index) {
    return AnimatedBuilder(
      animation: _animations[index],
      builder: (context, snapshot) {
        return Opacity(
          opacity: _animations[index].value,
          child: Text(
            textToDisplay[index],
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


