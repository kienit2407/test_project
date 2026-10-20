import 'package:flutter/material.dart';

import '../../../app/themes/app_color.dart';
import '../../../data/home_mock_data.dart';
import '../../../data/models/home_models.dart';
import 'product_carousel_section.dart';

class NewArrivalsSection extends StatelessWidget {
  const NewArrivalsSection({
    super.key,
    this.products,
    this.onViewAll,
    this.onProductTap,
    this.onBuyNow,
  });

  final List<ShopProduct>? products;
  final VoidCallback? onViewAll;
  final ValueChanged<ShopProduct>? onProductTap;
  final ValueChanged<ShopProduct>? onBuyNow;

  @override
  Widget build(BuildContext context) {
    return ProductCarouselSection(
      title: 'Hàng Mới Về',
      iconAsset: 'assets/svgs/ic_new_items.svg',
      products: products ?? HomeMockData.newArrivalProducts,
      backgroundColor: AppColor.primaryColor,
      titleColor: Colors.white,
      actionColor: Colors.white,
      onViewAll: onViewAll,
      onProductTap: onProductTap,
      onBuyNow: onBuyNow,
    );
  }
}
