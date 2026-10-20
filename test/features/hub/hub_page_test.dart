import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/core/cubit/tab_navigator_cubit.dart';
import 'package:test_project/data/home_mock_data.dart';
import 'package:test_project/features/hub/hub_page.dart';
import 'package:test_project/features/hub/widgets/hub_bottom_bar.dart';
import 'package:test_project/features/hub/widgets/hub_search_header.dart';

Future<void> _pumpHub(
  WidgetTester tester, {
  Size size = const Size(393, 852),
  bool reduceMotion = false,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  tester.view.padding = const FakeViewPadding(top: 44, bottom: 34);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetPadding);

  await tester.pumpWidget(
    ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(disableAnimations: reduceMotion),
          child: child!,
        ),
        home: const HubPage(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _tapTab(WidgetTester tester, int index) async {
  await tester.tap(find.byKey(ValueKey('hub-tab-$index')));
  await tester.pumpAndSettle();
}

ScrollPosition _scrollPosition(WidgetTester tester, String key) {
  final scrollable = find.descendant(
    of: find.byKey(PageStorageKey<String>(key)),
    matching: find.byType(Scrollable),
  );
  return tester.state<ScrollableState>(scrollable.first).position;
}

void main() {
  for (final size in [
    const Size(320, 568),
    const Size(393, 852),
    const Size(430, 932),
  ]) {
    testWidgets('five tabs retain one header at ${size.width}', (tester) async {
      await _pumpHub(tester, size: size);
      await tester.enterText(
        find.byKey(const ValueKey('hub-search')),
        'lọc dầu',
      );

      for (final index in [1, 2, 3, 4, 0]) {
        await _tapTab(tester, index);
        expect(find.byType(HubSearchHeader), findsOneWidget);
        expect(find.byType(HubBottomBar), findsOneWidget);
        final search = tester.widget<TextField>(
          find.byKey(const ValueKey('hub-search')),
        );
        expect(search.controller!.text, 'lọc dầu');
        expect(
          tester.widget<HubBottomBar>(find.byType(HubBottomBar)).currentIndex,
          index,
        );
        expect(tester.takeException(), isNull);
      }

      await tester.pumpWidget(const SizedBox.shrink());
    });
  }

  testWidgets('home and category scroll offsets survive tab changes', (
    tester,
  ) async {
    await _pumpHub(tester);
    await tester.drag(
      find.byKey(const PageStorageKey('home-scroll')),
      const Offset(0, -420),
    );
    await tester.pumpAndSettle();
    final homeOffset = _scrollPosition(tester, 'home-scroll').pixels;
    expect(homeOffset, greaterThan(0));

    await _tapTab(tester, 2);
    await tester.tap(find.byKey(const ValueKey('category-oil-filter')));
    await tester.pumpAndSettle();
    expect(
      tester.widget<Text>(find.byKey(const ValueKey('category-title'))).data,
      'Bộ Lọc Dầu',
    );
    await tester.drag(
      find.byKey(const PageStorageKey('category-content')),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    final categoryOffset = _scrollPosition(tester, 'category-content').pixels;
    expect(categoryOffset, greaterThan(0));

    await _tapTab(tester, 3);
    await _tapTab(tester, 2);
    expect(
      _scrollPosition(tester, 'category-content').pixels,
      closeTo(categoryOffset, 0.1),
    );
    await tester.tap(find.byKey(const ValueKey('category-air-filter')));
    await tester.pumpAndSettle();
    expect(_scrollPosition(tester, 'category-content').pixels, 0);

    await _tapTab(tester, 0);
    expect(
      _scrollPosition(tester, 'home-scroll').pixels,
      closeTo(homeOffset, 0.1),
    );
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'home category opens the matching catalog and back returns home',
    (tester) async {
      await _pumpHub(tester);
      await tester.tap(find.text(HomeMockData.categories[1].name));
      await tester.pumpAndSettle();
      expect(
        tester.widget<HubBottomBar>(find.byType(HubBottomBar)).currentIndex,
        2,
      );
      expect(
        tester.widget<Text>(find.byKey(const ValueKey('category-title'))).data,
        HomeMockData.categories[1].name,
      );
      await tester.tap(find.byTooltip('Về trang chủ'));
      await tester.pumpAndSettle();
      expect(find.text('Danh mục tiêu biểu'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('icons bounce on tap and reselect; reduced motion skips bounce', (
    tester,
  ) async {
    await _pumpHub(tester);
    final bounce = find.byKey(const ValueKey('hub-bounce-Danh mục'));
    expect(tester.widget<ScaleTransition>(bounce).scale.value, 1);
    for (var attempt = 0; attempt < 2; attempt++) {
      await tester.tap(find.byKey(const ValueKey('hub-tab-2')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 80));
      expect(tester.widget<ScaleTransition>(bounce).scale.value, isNot(1));
      await tester.pumpAndSettle();
      expect(tester.widget<ScaleTransition>(bounce).scale.value, 1);
    }

    await tester.pumpWidget(const SizedBox.shrink());
    await _pumpHub(tester, reduceMotion: true);
    await tester.tap(find.byKey(const ValueKey('hub-tab-2')));
    await tester.pump(const Duration(milliseconds: 80));
    expect(tester.widget<ScaleTransition>(bounce).scale.value, 1);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  test('tab cubit ignores invalid indices', () async {
    final cubit = TabNavigatorCubit();
    cubit.changeNavigator(2);
    expect(cubit.state, 2);
    cubit.changeNavigator(-1);
    cubit.changeNavigator(5);
    expect(cubit.state, 2);
    await cubit.close();
  });
}
