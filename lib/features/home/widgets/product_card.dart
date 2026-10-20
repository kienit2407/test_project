import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/themes/app_color.dart';
import '../../../data/models/home_models.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.showSaleProgress = false,
    this.showLowStockBadge = false,
    this.onTap,
    this.onBuyNow,
  });

  final ShopProduct product;
  final bool showSaleProgress;
  final bool showLowStockBadge;
  final VoidCallback? onTap;
  final VoidCallback? onBuyNow;

  String _formatPrice(int price) => price.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]},',
  );

  @override
  Widget build(BuildContext context) {
    final imageAsset = product.imageAsset;
    final originalPrice = product.originalPriceVnd;
    final hasDiscount =
        originalPrice != null && originalPrice > product.priceVnd;

    return Material(
      color: Colors.white,
      elevation: 1,
      shadowColor: const Color(0x0F000000),
      borderRadius: BorderRadius.circular(8.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: imageAsset == null
                      ? Icon(
                          Icons.image_outlined,
                          size: 48.r,
                          color: const Color(0xFF94A3B8),
                        )
                      : Image.asset(
                          imageAsset,
                          fit: BoxFit.contain,
                          semanticLabel: product.name,
                        ),
                ),
              ),
              SizedBox(height: 12.h),
              if (showLowStockBadge) ...[
                SizedBox(
                  height: 16.h,
                  child: product.stock == 1
                      ? _LowStockBadge(stock: product.stock)
                      : null,
                ),
                SizedBox(height: 12.h),
              ],
              SizedBox(
                height: 36.h,
                child: Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF212B36),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '${_formatPrice(product.priceVnd)} '),
                    const TextSpan(
                      text: 'đ',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFB71D18),
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                height: 16.h,
                child: hasDiscount
                    ? Row(
                        children: [
                          Flexible(
                            child: Text(
                              '${_formatPrice(originalPrice)} đ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: const Color(0xFF919EAB),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            '-${product.discountPercent}%',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: const Color(0xFFD00000),
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
              if (showSaleProgress) ...[
                SizedBox(height: 12.h),
                _SaleProgress(product: product),
                SizedBox(height: 4.h),
                Text(
                  'Đã bán ${product.soldCount} sản phẩm',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFF637381),
                  ),
                ),
              ],
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                height: 28.h,
                child: TextButton(
                  onPressed: product.stock > 0 ? onBuyNow : null,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: AppColor.primaryColor,
                    backgroundColor: const Color(0xFFE6F1FF),
                    disabledForegroundColor: product.stock > 0
                        ? AppColor.primaryColor
                        : const Color(0xFF919EAB),
                    disabledBackgroundColor: const Color(0xFFE6F1FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    textStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Text(product.stock > 0 ? 'Mua ngay' : 'Hết hàng'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LowStockBadge extends StatelessWidget {
  const _LowStockBadge({required this.stock});

  final int stock;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD666), Color(0xFFFFAB00)],
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/svgs/ic_slider_flashsale.svg',
              width: 12.r,
              height: 12.r,
            ),
            SizedBox(width: 3.w),
            Flexible(
              child: Text(
                'Chỉ còn $stock sản phẩm',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 8.sp,
                  height: 1,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7A0C2E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SaleProgress extends StatelessWidget {
  const _SaleProgress({required this.product});

  final ShopProduct product;

  @override
  Widget build(BuildContext context) {
    final total = product.soldCount + product.stock;
    final progress = total <= 0
        ? 0.0
        : (product.soldCount / total).clamp(0.0, 1.0);

    return SizedBox(
      height: 18.r,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final iconSize = 18.r.clamp(0.0, constraints.maxWidth);
          final iconOffset = (constraints.maxWidth * progress - iconSize / 2)
              .clamp(0.0, constraints.maxWidth - iconSize);

          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5D4D4),
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5630), Color(0xFFC92316)],
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
              ),
              Positioned(
                left: iconOffset,
                child: SvgPicture.asset(
                  'assets/svgs/ic_slider_flashsale.svg',
                  width: iconSize,
                  height: iconSize,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
