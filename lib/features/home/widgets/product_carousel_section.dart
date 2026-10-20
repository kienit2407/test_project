import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/themes/app_color.dart';
import '../../../data/models/home_models.dart';
import 'home_section_header.dart';
import 'product_card.dart';

/// Danh sách ngang dùng chung cho các section sản phẩm thông thường.
class ProductCarouselSection extends StatelessWidget {
  const ProductCarouselSection({
    super.key,
    required this.title,
    required this.iconAsset,
    required this.products,
    this.backgroundColor,
    this.titleColor = const Color(0xFF212B36),
    this.actionColor = AppColor.primaryColor,
    this.leadingImageAsset,
    this.leadingImageLabel,
    this.onLeadingTap,
    this.onViewAll,
    this.onProductTap,
    this.onBuyNow,
  });

  final String title;
  final String iconAsset;
  final List<ShopProduct> products;
  final Color? backgroundColor;
  final Color titleColor;
  final Color actionColor;
  final String? leadingImageAsset;
  final String? leadingImageLabel;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onViewAll;
  final ValueChanged<ShopProduct>? onProductTap;
  final ValueChanged<ShopProduct>? onBuyNow;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();
    final banner = leadingImageAsset;
    final leadingCount = banner == null ? 0 : 1;

    return DecoratedBox(
      decoration: BoxDecoration(color: backgroundColor),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: backgroundColor == null ? 0 : 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: HomeSectionHeader(
                title: title,
                iconAsset: iconAsset,
                titleColor: titleColor,
                actionColor: actionColor,
                onViewAll: onViewAll,
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 288.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                itemCount: products.length + leadingCount,
                separatorBuilder: (_, _) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  if (index == 0 && banner != null) {
                    return SizedBox(
                      width: 148.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: GestureDetector(
                          onTap: onLeadingTap,
                          child: Image.asset(
                            banner,
                            fit: BoxFit.cover,
                            semanticLabel: leadingImageLabel,
                          ),
                        ),
                      ),
                    );
                  }

                  final product = products[index - leadingCount];
                  final onTap = onProductTap;
                  final onBuy = onBuyNow;

                  return SizedBox(
                    width: 148.w,
                    child: ProductCard(
                      product: product,
                      onTap: onTap == null ? null : () => onTap(product),
                      onBuyNow: onBuy == null ? null : () => onBuy(product),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
