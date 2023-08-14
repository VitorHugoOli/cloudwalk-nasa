import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ConfigsStars {
  static int size = 100;
  static int lifeTimeSeconds = 18;
  static int minBlinkPerLife = 3;
}

class StarryBackground extends StatefulWidget {
  final Widget child;

  const StarryBackground({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _StarryBackgroundState();
}

class _StarryBackgroundState extends State<StarryBackground>
    with TickerProviderStateMixin {
  List<Star> stars = [];

  @override
  void initState() {
    super.initState();
    // After the first frame, start adding stars.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < ConfigsStars.size; i++) {
        Random rand = Random(i);
        Timer(Duration(seconds: rand.nextInt(5)), () {
          stars.add(Star(random: rand, vsync: this, context: context));
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    for (final star in stars) {
      star.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...stars.map((star) => AnimatedBuilder(
              animation: star.animationController,
              builder: (context, child) {
                return Positioned(
                  left: star.x,
                  top: star.y,
                  child: Opacity(
                    opacity: star.animationController.value,
                    child: Container(
                      width: 2,
                      height: 2,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            )),
        widget.child,
      ],
    );
  }
}

class Star {
  final Random random;
  final TickerProvider vsync;
  final BuildContext context;
  late final AnimationController animationController;
  late double x;
  late double y;
  static int lifeTime = ConfigsStars.lifeTimeSeconds;

  // We need to calculate the amount of time that takes to animate the brightness of the star
  // Considering that the animation takes the same time to forward and reverse
  // So, we need to divide the lifeTime by the minimum number of blink per life to discover the time of each blink
  // And then, divide by 2 to get the time of each animation
  static int secToAnimateBlink =
      (ConfigsStars.lifeTimeSeconds / ConfigsStars.minBlinkPerLife / 2).floor();

  Star({required this.random, required this.vsync, required this.context}) {
    x = random.nextDouble() *
        MediaQuery.of(context).size.width; // width of the screen
    y = random.nextDouble() *
        MediaQuery.of(context).size.height; // height of the screen

    clock();

    animationController = AnimationController(
      duration: Duration(
          seconds:
              (random.nextInt(lifeTime + 1) + secToAnimateBlink) % lifeTime +
                  1),
      vsync: vsync,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      })
      ..forward();
  }

  void clock() {
    // After 18 seconds, change the position of the star
    Timer(Duration(seconds: lifeTime), () {
      changePosition();
      animationController.reset();
      animationController.forward();
      clock();
    });
  }

  void changePosition() {
    x = random.nextDouble() *
        MediaQuery.of(context).size.width; // width of the screen
    y = random.nextDouble() *
        MediaQuery.of(context).size.height; // height of the screen
  }

  void dispose() {
    animationController.dispose();
  }
}
