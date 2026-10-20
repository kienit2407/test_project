import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/data/home_mock_data.dart';
import 'package:test_project/data/models/home_models.dart';
import 'package:test_project/features/home/widgets/best_seller_section.dart';
import 'package:test_project/features/home/widgets/product_card.dart';

Future<void> _pumpSection(
  WidgetTester tester, {
  List<ShopProduct>? products,
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
              BestSellerSection(
                products: products,
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
    testWidgets('best sellers fit ${size.width} x ${size.height}', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      await _pumpSection(tester);

      expect(find.text('Sản Phẩm Bán Chạy'), findsOneWidget);
      expect(find.text('Chỉ còn 1 sản phẩm'), findsWidgets);
      expect(find.textContaining('Đã bán'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('stock controls badge and buying; actions receive the product', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(393, 852);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    final products = [
      HomeMockData.products[0],
      HomeMockData.products[1],
      const ShopProduct(
        id: 'sold-out',
        name: 'Sản phẩm hết hàng',
        categoryId: 'oil-filter',
        brandId: 'honda',
        priceVnd: 299000,
        stock: 0,
      ),
    ];
    var viewAllCalls = 0;
    ShopProduct? tappedProduct;
    ShopProduct? boughtProduct;

    await _pumpSection(
      tester,
      products: products,
      onViewAll: () => viewAllCalls++,
      onProductTap: (product) => tappedProduct = product,
      onBuyNow: (product) => boughtProduct = product,
    );

    expect(find.text('Chỉ còn 1 sản phẩm'), findsOneWidget);
    expect(find.text('Chỉ còn 12 sản phẩm'), findsNothing);

    await tester.tap(find.text('Xem tất cả'));
    await tester.tap(find.byType(ProductCard).first);
    await tester.tap(find.widgetWithText(TextButton, 'Mua ngay').first);
    expect(viewAllCalls, 1);
    expect(tappedProduct, same(products.first));
    expect(boughtProduct, same(products.first));

    await tester.drag(find.byType(ListView).last, const Offset(-800, 0));
    await tester.pumpAndSettle();
    expect(find.text('Sản phẩm hết hàng'), findsOneWidget);
    final button = tester.widget<TextButton>(
      find.widgetWithText(TextButton, 'Hết hàng'),
    );
    expect(button.onPressed, isNull);
    expect(tester.takeException(), isNull);

    await _pumpSection(tester, products: []);
    expect(find.text('Sản Phẩm Bán Chạy'), findsNothing);
  });
}
