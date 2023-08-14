import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Lottie.asset('assets/not_found.json'),
    );
  }
}
