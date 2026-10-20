import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/themes/app_color.dart';

class PromotionSection extends StatelessWidget {
  const PromotionSection({super.key, this.onPromotionTap});

  /// 0: mua 1 tặng 1; 1: xả kho; 2: đồng giá 299K.
  final ValueChanged<int>? onPromotionTap;

  @override
  Widget build(BuildContext context) {
    final onTap = onPromotionTap;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final gap = 12.w;
          final tileWidth = (constraints.maxWidth - gap) / 2;
          final smallHeight = tileWidth * 130 / 180;

          return SizedBox(
            height: smallHeight * 2 + gap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: _SmallPromotionTile(
                          title: 'MUA 1\nTẶNG 1',
                          imageAsset: 'assets/images/promotion_1.png',
                          backgroundColor: const Color(0xFFB71D18),
                          textColor: Colors.white,
                          onTap: onTap == null ? null : () => onTap(0),
                        ),
                      ),
                      SizedBox(height: gap),
                      Expanded(
                        child: _SmallPromotionTile(
                          title: 'XẢ KHO\nGIÁ SỐC',
                          imageAsset: 'assets/images/promotion_2.png',
                          backgroundColor: const Color(0xFFFFAB00),
                          textColor: const Color(0xFF212B36),
                          onTap: onTap == null ? null : () => onTap(1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: Material(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: onTap == null ? null : () => onTap(2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFF0BD), Color(0xFFFFDC73)],
                              ),
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(20.r),
                              ),
                            ),
                            child: Text(
                              'Mới cực hot!',
                              style: TextStyle(
                                fontSize: 12.sp,
                                height: 1.2,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFB71D18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ĐỒNG GIÁ',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '299K',
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    height: 1.2,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                'assets/images/promotion_3.png',
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SmallPromotionTile extends StatelessWidget {
  const _SmallPromotionTile({
    required this.title,
    required this.imageAsset,
    required this.backgroundColor,
    required this.textColor,
    this.onTap,
  });

  final String title;
  final String imageAsset;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
              ),
              Expanded(child: Image.asset(imageAsset, fit: BoxFit.contain)),
            ],
          ),
        ),
      ),
    );
  }
}
