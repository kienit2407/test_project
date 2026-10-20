import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/themes/app_color.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    required this.iconAsset,
    this.titleColor = const Color(0xFF212B36),
    this.actionColor = AppColor.primaryColor,
    this.onViewAll,
  });

  final String title;
  final String iconAsset;
  final Color titleColor;
  final Color actionColor;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconAsset, width: 24.r, height: 24.r),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: titleColor,
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
                    color: actionColor,
                  ),
                ),
                SizedBox(width: 6.w),
                SvgPicture.asset(
                  'assets/svgs/ic_arrow.svg',
                  width: 12.r,
                  height: 12.r,
                  colorFilter: ColorFilter.mode(actionColor, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
