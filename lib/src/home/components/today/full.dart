import 'package:cloudwalknasa/components/animations/load.dart';
import 'package:cloudwalknasa/components/animations/not_found.dart';
import 'package:cloudwalknasa/components/full.dart';
import 'package:cloudwalknasa/models/apod.dart';
import 'package:cloudwalknasa/services/api.dart';
import 'package:flutter/material.dart';

class TodayViewPage extends StatefulWidget {
  const TodayViewPage({Key? key}) : super(key: key);

  @override
  State<TodayViewPage> createState() => _TodayViewPageState();
}

class _TodayViewPageState extends State<TodayViewPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Apod?>(
      future: NasaApi.instance.getApod(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        } else if (snapshot.hasData) {
          return FullView(apod: snapshot.data);
        } else if (snapshot.hasError) {
          return const NotFound();
        }
        return Container(); // Fallback empty container
      },
    );
  }
}
