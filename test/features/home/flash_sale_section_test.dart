import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/data/home_mock_data.dart';
import 'package:test_project/data/models/home_models.dart';
import 'package:test_project/features/home/widgets/flash_sale_section.dart';
import 'package:test_project/features/home/widgets/product_card.dart';

Future<void> _pumpSection(
  WidgetTester tester, {
  FlashSaleData data = HomeMockData.flashSale,
  VoidCallback? onViewAll,
  ValueChanged<ShopProduct>? onProductTap,
  ValueChanged<ShopProduct>? onBuyNow,
}) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      child: MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              FlashSaleSection(
                data: data,
                onViewAll: onViewAll,
                onProductTap: onProductTap,
                onBuyNow: onBuyNow,
              ),
            ],
          ),
        ),
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
    testWidgets('flash sale fits ${size.width} x ${size.height}', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      await _pumpSection(tester);

      expect(find.text('FLASH SALE'), findsOneWidget);
      expect(find.text('19'), findsOneWidget);
      expect(find.text('25'), findsOneWidget);
      expect(find.text('Đã bán 88 sản phẩm'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
    });
  }

  testWidgets('actions receive the product and list scrolls horizontally', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(393, 852);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    var viewAllCalls = 0;
    ShopProduct? tappedProduct;
    ShopProduct? boughtProduct;

    await _pumpSection(
      tester,
      onViewAll: () => viewAllCalls++,
      onProductTap: (product) => tappedProduct = product,
      onBuyNow: (product) => boughtProduct = product,
    );

    await tester.tap(find.text('Xem tất cả'));
    await tester.tap(find.byType(ProductCard).first);
    await tester.tap(find.widgetWithText(TextButton, 'Mua ngay').first);

    expect(viewAllCalls, 1);
    expect(tappedProduct, same(HomeMockData.products.first));
    expect(boughtProduct, same(HomeMockData.products.first));

    await tester.drag(find.byType(ListView).last, const Offset(-1800, 0));
    await tester.pumpAndSettle();

    expect(find.text(HomeMockData.products.last.name), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('empty sale is hidden and expired sale displays zero', (
    tester,
  ) async {
    await _pumpSection(
      tester,
      data: const FlashSaleData(remainingTime: Duration.zero, products: []),
    );
    expect(find.text('FLASH SALE'), findsNothing);

    await _pumpSection(
      tester,
      data: const FlashSaleData(
        remainingTime: Duration.zero,
        products: HomeMockData.products,
      ),
    );
    expect(find.text('00'), findsNWidgets(3));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
