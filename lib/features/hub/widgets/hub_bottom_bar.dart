import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/themes/app_color.dart';

class HubBottomBar extends StatelessWidget {
  const HubBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.cartCount = 0,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final int cartCount;

  static const _tabs = [
    (label: 'Trang chủ', icon: 'assets/svgs/ic_hub_home.svg'),
    (label: 'Giỏ hàng', icon: 'assets/svgs/ic_hub_cart.svg'),
    (label: 'Danh mục', icon: 'assets/svgs/ic_hub_cate.svg'),
    (label: 'Tin tức', icon: 'assets/svgs/ic_hub_article.svg'),
    (label: 'Tài khoản', icon: 'assets/svgs/ic_hub_user.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return ColoredBox(
      color: const Color(0xFFF7F8FA),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64.h,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final tabWidth = constraints.maxWidth / _tabs.length;
                final indicatorWidth = 48.w.clamp(0.0, tabWidth);

                return Stack(
                  children: [
                    AnimatedPositionedDirectional(
                      duration: reduceMotion
                          ? Duration.zero
                          : const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      start:
                          currentIndex * tabWidth +
                          (tabWidth - indicatorWidth) / 2,
                      top: 0,
                      width: indicatorWidth,
                      height: 12.h,
                      child: Column(
                        children: [
                          Container(
                            height: 3.h,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(4.r),
                              ),
                            ),
                          ),
                          Expanded(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColor.primaryColor.withValues(
                                      alpha: 0.15,
                                    ),
                                    AppColor.primaryColor.withValues(alpha: 0),
                                  ],
                                ),
                              ),
                              child: const SizedBox.expand(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        for (var index = 0; index < _tabs.length; index++)
                          Expanded(
                            child: _HubTabItem(
                              key: ValueKey('hub-tab-$index'),
                              label: _tabs[index].label,
                              iconAsset: _tabs[index].icon,
                              selected: index == currentIndex,
                              badgeCount: index == 1 ? cartCount : 0,
                              onTap: () => onTap(index),
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _HubTabItem extends StatefulWidget {
  const _HubTabItem({
    super.key,
    required this.label,
    required this.iconAsset,
    required this.selected,
    required this.onTap,
    this.badgeCount = 0,
  });

  final String label;
  final String iconAsset;
  final bool selected;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  State<_HubTabItem> createState() => _HubTabItemState();
}

class _HubTabItemState extends State<_HubTabItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 380),
  );
  late final Animation<double> _scale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: 0.82,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 25,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.82,
        end: 1.15,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 35,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.15,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 40,
    ),
  ]).animate(_controller);

  void _onTap() {
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.reset();
    } else {
      _controller.forward(from: 0);
    }
    widget.onTap();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.selected
        ? AppColor.primaryColor
        : const Color(0xFFC4CDD5);

    return Semantics(
      label: widget.label,
      button: true,
      selected: widget.selected,
      child: InkWell(
        onTap: _onTap,
        child: ExcludeSemantics(
          child: SizedBox(
            height: 64.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  key: ValueKey('hub-bounce-${widget.label}'),
                  scale: _scale,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SvgPicture.asset(
                        widget.iconAsset,
                        width: 24.r,
                        height: 24.r,
                        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                      ),
                      if (widget.badgeCount > 0)
                        Positioned(
                          top: -5.r,
                          right: -7.r,
                          child: Container(
                            constraints: BoxConstraints(minWidth: 16.r),
                            height: 16.r,
                            padding: EdgeInsets.symmetric(horizontal: 3.r),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF424F),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              widget.badgeCount > 99
                                  ? '99+'
                                  : '${widget.badgeCount}',
                              style: TextStyle(
                                fontSize: 8.sp,
                                height: 1,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  widget.label,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: widget.selected
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: widget.selected
                        ? AppColor.primaryColor
                        : const Color(0xFF919EAB),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
