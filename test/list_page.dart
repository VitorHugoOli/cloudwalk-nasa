import 'package:cloudwalknasa/components/animations/load.dart';
import 'package:cloudwalknasa/envs/production.dart';
import 'package:cloudwalknasa/services/api.dart';
import 'package:cloudwalknasa/src/home/components/list/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  group('ListViewPage', () {
    NasaApi.instance.init(ProductionEnv().NASAAPIKEY);
    initializeDateFormatting('pt_BR', null);

    // 1. Test for initial state
    testWidgets('shows loader initially', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ListViewPage()));

      // Pump a duration to allow StreamBuilder to receive the loading state
      await tester.pump(Duration.zero);

      expect(find.byType(Loader), findsOneWidget);
    });

    testWidgets('displays list of ApodCards when not loading',
        (WidgetTester tester) async {});

    testWidgets('shows PaginationWidget with correct page data',
        (WidgetTester tester) async {});

    testWidgets(
        'displays date range when provided', (WidgetTester tester) async {});
  });
}
