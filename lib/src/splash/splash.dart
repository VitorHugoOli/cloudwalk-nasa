import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _firstWordAnimation;
  late Animation<double> _secondWordAnimation;
  bool isAnimated = true;
  List<String> words = ["NASA", "Gallery".toUpperCase()];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6), // 2 seconds for each part
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          1.0 / 3, // Appear in the first 2 seconds
          curve: Curves.easeIn,
        ),
      ),
    );

    _firstWordAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          1.0 / 3,
          2.0 / 3, // Appear in the second 2 seconds
          curve: Curves.easeIn,
        ),
      ),
    );

    _secondWordAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          2.0 / 3,
          1.0, // Appear in the last 2 seconds
          curve: Curves.easeIn,
        ),
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _logoAnimation,
              child: Image.asset('assets/nasa-logo.png', width: 300),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _firstWordAnimation,
              child: Text(
                words[0],
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Nasa",
                ),
              ),
            ),
            FadeTransition(
              opacity: _secondWordAnimation,
              child: Text(
                words[1],
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Nasa",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
