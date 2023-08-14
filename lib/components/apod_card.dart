import 'package:cloudwalknasa/components/full.dart';
import 'package:cloudwalknasa/models/apod.dart';
import 'package:flutter/material.dart';

class ApodCard extends StatelessWidget {
  const ApodCard({
    super.key,
    required this.apod,
    required this.date,
  });

  final Apod apod;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        // You may adjust this according to the actual aspect ratio of the images
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Image.network(
                apod.url,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    apod.title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                '/fullView',
                arguments: FullViewArgs(apod: apod, hasBackButton: true),
              ),
            )
          ],
        ),
      ),
    );
  }
}