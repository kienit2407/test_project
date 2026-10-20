import 'package:flutter/material.dart';

import '../../../data/home_mock_data.dart';
import '../../../data/models/home_models.dart';
import 'product_carousel_section.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({
    super.key,
    this.products,
    this.onBannerTap,
    this.onViewAll,
    this.onProductTap,
    this.onBuyNow,
  });

  final List<ShopProduct>? products;
  final VoidCallback? onBannerTap;
  final VoidCallback? onViewAll;
  final ValueChanged<ShopProduct>? onProductTap;
  final ValueChanged<ShopProduct>? onBuyNow;

  @override
  Widget build(BuildContext context) {
    return ProductCarouselSection(
      title: 'Dành Cho Bạn',
      iconAsset: 'assets/svgs/ic_for_u.svg',
      products: products ?? HomeMockData.recommendedProducts,
      leadingImageAsset: HomeMockData.recommendationBannerAsset,
      leadingImageLabel: 'Bộ lọc chất lượng cao',
      onLeadingTap: onBannerTap,
      onViewAll: onViewAll,
      onProductTap: onProductTap,
      onBuyNow: onBuyNow,
    );
  }
}
