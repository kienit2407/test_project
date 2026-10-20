import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/themes/app_color.dart';

class HubSearchHeader extends StatelessWidget {
  const HubSearchHeader({
    super.key,
    required this.controller,
    this.showBackButton = false,
    this.onBack,
    this.onSearch,
    this.onCameraTap,
    this.onNotificationsTap,
  });

  final TextEditingController controller;
  final bool showBackButton;
  final VoidCallback? onBack;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onCameraTap;
  final VoidCallback? onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.r),
      borderSide: BorderSide.none,
    );

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 18.h),
        child: Row(
          children: [
            if (showBackButton) ...[
              IconButton(
                tooltip: 'Về trang chủ',
                onPressed: onBack,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 28.w, minHeight: 36.h),
                icon: Icon(Icons.chevron_left, color: Colors.white, size: 28.r),
              ),
              SizedBox(width: 8.w),
            ],
            Expanded(
              child: SizedBox(
                height: 36.h,
                child: TextField(
                  key: const ValueKey('hub-search'),
                  controller: controller,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.search,
                  cursorColor: AppColor.primaryColor,
                  style: TextStyle(fontSize: 14.sp, height: 1.2),
                  onSubmitted: onSearch,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Tìm kiếm sản phẩm',
                    hintStyle: TextStyle(
                      color: const Color(0xFF94A3B8),
                      fontSize: 14.sp,
                      height: 1.2,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 40.w,
                      minHeight: 0,
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 40.w,
                      minHeight: 0,
                    ),
                    prefixIcon: Center(
                      widthFactor: 1,
                      heightFactor: 1,
                      child: SvgPicture.asset(
                        'assets/svgs/ic_search.svg',
                        width: 20.r,
                        height: 20.r,
                      ),
                    ),
                    suffixIcon: IconButton(
                      tooltip: 'Tìm kiếm bằng hình ảnh',
                      onPressed: onCameraTap,
                      padding: EdgeInsets.all(6.r),
                      icon: SvgPicture.asset(
                        'assets/svgs/ic_camera.svg',
                        width: 20.r,
                        height: 20.r,
                      ),
                    ),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            IconButton(
              tooltip: 'Thông báo',
              onPressed: onNotificationsTap,
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/ic_notification.svg',
                    width: 24.r,
                    height: 24.r,
                  ),
                  Positioned(
                    top: -3.r,
                    right: -3.r,
                    child: Container(
                      width: 10.r,
                      height: 10.r,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF5630),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.primaryColor,
                          width: 1.5.r,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
