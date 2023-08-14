import 'package:cloudwalknasa/components/animations/load.dart';
import 'package:cloudwalknasa/components/animations/not_found.dart';
import 'package:cloudwalknasa/main.dart';
import 'package:cloudwalknasa/models/apod.dart';
import 'package:flutter/material.dart';

class FullViewArgs {
  final Apod? apod;
  final bool hasBackButton;

  const FullViewArgs({
    this.apod,
    this.hasBackButton = false,
  });
}

class FullView extends StatelessWidget {
  final Apod? apod;
  final bool hasBackButton;

  const FullView({
    super.key,
    required this.apod,
    this.hasBackButton = false,
  });

  buildImage(String url, double? loadingProgress, BuildContext context,
      bool isLandscape) {
    return Stack(
      children: [
        Image.network(
          url,
          loadingBuilder: (context, child, loadingProgress) =>
              loadingProgress == null ? child : const Loader(),
          fit: isLandscape ? BoxFit.contain : BoxFit.cover,
          height: MediaQuery.of(navigatorKey.currentContext!).size.height,
          width: MediaQuery.of(navigatorKey.currentContext!).size.width,
          alignment: Alignment.center,
        ),
        //Create a load based on the loadingProgress 0 to 1 that be in the left top side of the screen
        Positioned(
          top: MediaQuery.of(context).padding.top + 30,
          right: 30,
          child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(value: loadingProgress)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (apod == null) {
      return const NotFound();
    }
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () => print('double tap'),
        child: Stack(
          children: [
            Image.network(
              apod!.hdurl ?? apod!.url,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }

                double loadingProgressPercentage =
                    loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!;

                return buildImage(
                    apod!.url, loadingProgressPercentage, context, isLandscape);
              },
              fit: isLandscape ? BoxFit.contain : BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            if (hasBackButton)
              Positioned(
                top: MediaQuery.paddingOf(context).top + 30,
                left: 30,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),
            Positioned(
              left: 30,
              bottom: MediaQuery.paddingOf(context).bottom + 40,
              child: InfoPanel(data: apod!),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoPanel extends StatefulWidget {
  final Apod data;

  const InfoPanel({super.key, required this.data});

  @override
  State<InfoPanel> createState() => _InfoPanelState();
}

class _InfoPanelState extends State<InfoPanel> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.data.title, style: const TextStyle(fontSize: 14)),
              Text(widget.data.date, style: const TextStyle(fontSize: 12)),
            ],
          ),
          trailing: const Icon(Icons.info, color: Colors.white70),
          tilePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          expandedAlignment: Alignment.centerLeft,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: Theme(
                data: ThemeData(
                  scrollbarTheme: ScrollbarThemeData(
                    thumbColor: MaterialStateProperty.all(Colors.white),
                  ),
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 100,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.data.explanation,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
