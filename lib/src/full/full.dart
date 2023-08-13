import 'package:cloudwalknasa/services/api.dart';
import 'package:cloudwalknasa/services/audio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FullViewPage extends StatefulWidget {
  const FullViewPage({Key? key}) : super(key: key);

  @override
  _FullViewPageState createState() => _FullViewPageState();
}

class _FullViewPageState extends State<FullViewPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Future<dynamic> _future;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _future = NasaApi.instance.getApod();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Lottie.asset('assets/data.json'); // Loading animation
        } else if (snapshot.hasData) {
          return GestureDetector(
            onDoubleTap: () => print('double tap'),
            child: Stack(
              children: [
                Image.network(
                  snapshot.data!.url,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
                Positioned(
                  left: 30,
                  bottom: 100,
                  child: InfoPanel(
                    data: snapshot.data!,
                    animationController: _controller,
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Lottie.asset('assets/animation_ll1qdjwt.json'); // Not found animation
        }
        return Container(); // Fallback empty container
      },
    );
  }
}

class InfoPanel extends StatelessWidget {
  final dynamic data;
  final AnimationController animationController;

  InfoPanel({required this.data, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoHeader(context),
        _buildExplanationPanel(),
      ],
    );
  }

  Widget _buildInfoHeader(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.title),
            Text(data.date),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            if (animationController.status == AnimationStatus.completed) {
              animationController.reverse();
            } else {
              animationController.forward();
            }
          },
        ),
      ],
    );
  }

  Widget _buildExplanationPanel() {
    return ValueListenableBuilder(
      valueListenable: animationController,
      builder: (context, double value, _) {
        return Container(
          height: 100 * value,
          color: Colors.black.withOpacity(0.8),
          child: SingleChildScrollView(
            child: Text(
              'Explanation goes here...',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

