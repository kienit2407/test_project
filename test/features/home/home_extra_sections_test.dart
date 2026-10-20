import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/data/home_mock_data.dart';
import 'package:test_project/data/models/home_models.dart';
import 'package:test_project/features/home/widgets/article_section.dart';
import 'package:test_project/features/home/widgets/new_arrivals_section.dart';
import 'package:test_project/features/home/widgets/product_card.dart';
import 'package:test_project/features/home/widgets/promotion_section.dart';
import 'package:test_project/features/home/widgets/recommended_section.dart';

Future<void> _pumpContent(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      child: MaterialApp(
        home: Scaffold(body: ListView(children: [child])),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  for (final size in [
    const Size(320, 568),
    const Size(393, 852),
    const Size(430, 932),
  ]) {
    testWidgets('extra sections fit ${size.width} x ${size.height}', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      await _pumpContent(
        tester,
        Builder(
          builder: (context) => Column(
            children: [
              const PromotionSection(),
              SizedBox(height: 24.h),
              const RecommendedSection(),
              SizedBox(height: 24.h),
              const NewArrivalsSection(),
              SizedBox(height: 24.h),
              const ArticleSection(),
            ],
          ),
        ),
      );

      expect(find.text('MUA 1\nTẶNG 1'), findsOneWidget);
      expect(find.text('Dành Cho Bạn'), findsOneWidget);
      expect(find.text('Hàng Mới Về'), findsOneWidget);
      expect(find.text('Bài Viết Nổi Bật'), findsOneWidget);
      expect(find.text('13/02/2025'), findsNWidgets(3));
      expect(find.textContaining('Chỉ còn'), findsNothing);
      expect(find.textContaining('Đã bán'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('recommended banner and product actions are independent', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(393, 852);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    var bannerCalls = 0;
    var viewAllCalls = 0;
    ShopProduct? tappedProduct;
    ShopProduct? boughtProduct;

    await _pumpContent(
      tester,
      RecommendedSection(
        onBannerTap: () => bannerCalls++,
        onViewAll: () => viewAllCalls++,
        onProductTap: (product) => tappedProduct = product,
        onBuyNow: (product) => boughtProduct = product,
      ),
    );

    final banner = find.byWidgetPredicate((widget) {
      return widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              HomeMockData.recommendationBannerAsset;
    });
    await tester.tap(banner);
    await tester.tap(find.text('Xem tất cả'));
    await tester.tap(find.byType(ProductCard).first);
    await tester.tap(find.widgetWithText(TextButton, 'Mua ngay').first);

    expect(bannerCalls, 1);
    expect(viewAllCalls, 1);
    expect(tappedProduct, same(HomeMockData.recommendedProducts.first));
    expect(boughtProduct, same(HomeMockData.recommendedProducts.first));

    await tester.drag(find.byType(ListView).last, const Offset(-1200, 0));
    await tester.pumpAndSettle();
    expect(
      find.text(HomeMockData.recommendedProducts.last.name),
      findsOneWidget,
    );

    await _pumpContent(
      tester,
      NewArrivalsSection(onBuyNow: (product) => boughtProduct = product),
    );
    await tester.tap(find.widgetWithText(TextButton, 'Mua ngay').first);
    expect(boughtProduct, same(HomeMockData.newArrivalProducts.first));
    expect(tester.takeException(), isNull);
  });

  testWidgets('promotion and article callbacks identify the selected item', (
    tester,
  ) async {
    final promotions = <int>[];
    await _pumpContent(
      tester,
      PromotionSection(onPromotionTap: promotions.add),
    );

    await tester.tap(find.text('MUA 1\nTẶNG 1'));
    await tester.tap(find.text('XẢ KHO\nGIÁ SỐC'));
    await tester.tap(find.text('299K'));
    expect(promotions, [0, 1, 2]);

    ShopArticle? selectedArticle;
    var viewAllCalls = 0;
    await _pumpContent(
      tester,
      ArticleSection(
        onArticleTap: (article) => selectedArticle = article,
        onViewAll: () => viewAllCalls++,
      ),
    );
    await tester.tap(find.text('Xem tất cả'));
    await tester.tap(find.text(HomeMockData.articles.first.title));
    expect(viewAllCalls, 1);
    expect(selectedArticle, same(HomeMockData.articles.first));
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty product and article lists hide their sections', (
    tester,
  ) async {
    await _pumpContent(
      tester,
      const Column(
        children: [
          RecommendedSection(products: []),
          NewArrivalsSection(products: []),
          ArticleSection(articles: []),
        ],
      ),
    );
    expect(find.text('Dành Cho Bạn'), findsNothing);
    expect(find.text('Hàng Mới Về'), findsNothing);
    expect(find.text('Bài Viết Nổi Bật'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
