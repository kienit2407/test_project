// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:test_project/app.dart';
import 'package:test_project/app/di/get_it.dart';
import 'package:test_project/app/navigation/app_route.dart';
import 'package:test_project/features/hub/widgets/hub_bottom_bar.dart';
import 'package:test_project/features/hub/widgets/hub_search_header.dart';

void main() {
  testWidgets('app starts at Hub with home content and shared navigation', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(393, 852);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await initGetit();
    final router = getIt<AppRoute>();
    addTearDown(() async {
      router.dispose();
      await getIt.reset();
    });

    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(HubSearchHeader), findsOneWidget);
    expect(find.byType(HubBottomBar), findsOneWidget);
    expect(find.text('Danh mục tiêu biểu'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
