import 'package:cloudwalknasa/components/full.dart';
import 'package:cloudwalknasa/envs/production.dart';
import 'package:cloudwalknasa/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloudwalknasa/models/apod.dart';
import 'package:cloudwalknasa/components/animations/not_found.dart';

void main() {
  group('FullView', () {
    NasaApi.instance.init(ProductionEnv().NASAAPIKEY);

    testWidgets('renders NotFound widget when apod is null',
        (WidgetTester tester) async {
      // Build the FullView widget with apod as null
      await tester.pumpWidget(const MaterialApp(home: FullView(apod: null)));

      // Check if the NotFound widget is found in the widget tree
      expect(find.byType(NotFound), findsOneWidget);
    });

    testWidgets('renders correctly when apod is provided',
        (WidgetTester tester) async {
      
      // Sample Apod object
      final Apod apod = Apod(
        url: 'https://apod.nasa.gov/apod/image/1204/NGC5128_starshadows900.jpg',
        hdurl: 'https://apod.nasa.gov/apod/image/1204/NGC5128_starshadows.jpg',
        title: 'Test Title',
        date: '2023-08-14',
        explanation: 'Test Explanation',
        mediaType: 'image',
        serviceVersion: 'v1',
      );

      // Build the FullView widget with a given apod
      await tester.pumpWidget(MaterialApp(home: FullView(apod: apod)));

      // Verify if the image, title, and date are rendered
      expect(find.byType(Image), findsWidgets);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('2023-08-14'), findsOneWidget);

      // You may add more checks based on the functionalities you want to ensure
    });
  });
}
