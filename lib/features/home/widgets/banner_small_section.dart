import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/themes/app_color.dart';

class BannerSmallSection extends StatefulWidget {
  const BannerSmallSection({
    super.key,
    required this.imageAssets,
    this.height,
    this.onBannerTap,
  }) : assert(height == null || height > 0);

  final List<String> imageAssets;
  final double? height;
  final ValueChanged<int>? onBannerTap;

  @override
  State<BannerSmallSection> createState() => _BannerSmallSectionState();
}

class _BannerSmallSectionState extends State<BannerSmallSection> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.imageAssets.isEmpty) return const SizedBox.shrink();

    final currentPage = _currentPage.clamp(0, widget.imageAssets.length - 1);
    final onBannerTap = widget.onBannerTap;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: widget.height ?? 140.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: PageView.builder(
              itemCount: widget.imageAssets.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: onBannerTap == null ? null : () => onBannerTap(index),
                  child: Image.asset(
                    widget.imageAssets[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ),
        if (widget.imageAssets.length > 1) ...[
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.imageAssets.length, (index) {
              final isActive = index == currentPage;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  width: isActive ? 20.w : 10.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColor.primaryColor
                        : const Color(0xFFC4CDD5),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}
