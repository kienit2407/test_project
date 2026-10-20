import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/themes/app_color.dart';
import '../../../data/home_mock_data.dart';
import '../../../data/models/home_models.dart';
import 'product_card.dart';

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({
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
    final items = products ?? HomeMockData.bestSellingProducts;
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/svgs/ic_best_seller.svg',
                width: 24.r,
                height: 24.r,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Sản Phẩm Bán Chạy',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF212B36),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: onViewAll,
                borderRadius: BorderRadius.circular(4.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Xem tất cả',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      SvgPicture.asset(
                        'assets/svgs/ic_arrow.svg',
                        width: 12.r,
                        height: 12.r,
                        colorFilter: const ColorFilter.mode(
                          AppColor.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 320.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            itemCount: items.length,
            separatorBuilder: (_, _) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final product = items[index];
              final onTap = onProductTap;
              final onBuy = onBuyNow;

              return SizedBox(
                width: 148.w,
                child: ProductCard(
                  product: product,
                  showLowStockBadge: true,
                  onTap: onTap == null ? null : () => onTap(product),
                  onBuyNow: onBuy == null ? null : () => onBuy(product),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
