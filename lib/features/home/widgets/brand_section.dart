import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/home_mock_data.dart';
import '../../../data/models/home_models.dart';

class BrandSection extends StatelessWidget {
  const BrandSection({
    super.key,
    this.brands = HomeMockData.brands,
    this.onBrandTap,
  });

  final List<ShopBrand> brands;
  final ValueChanged<ShopBrand>? onBrandTap;

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/svgs/ic_brand.svg',
              width: 24.r,
              height: 24.r,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Thương Hiệu Nổi Bật',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF212B36),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        GridView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: brands.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
            childAspectRatio: 1.25,
          ),
          itemBuilder: (context, index) {
            final brand = brands[index];
            final onTap = onBrandTap;

            return _BrandItem(
              brand: brand,
              onTap: onTap == null ? null : () => onTap(brand),
            );
          },
        ),
      ],
    );
  }
}

class _BrandItem extends StatelessWidget {
  const _BrandItem({required this.brand, this.onTap});

  final ShopBrand brand;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final logoAsset = brand.logoAsset;

    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.r),
        side: BorderSide(color: const Color(0xFFEBEEF0), width: 1.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(6.r),
          child: logoAsset == null
              ? Center(
                  child: Text(
                    brand.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                )
              : Image.asset(
                  logoAsset,
                  fit: BoxFit.contain,
                  semanticLabel: brand.name,
                ),
        ),
      ),
    );
  }
}
