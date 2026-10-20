import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/home_mock_data.dart';
import '../../../data/models/home_models.dart';
import 'product_card.dart';

const _flashAccent = Color(0xFFFF5630);

class FlashSaleSection extends StatelessWidget {
  const FlashSaleSection({
    super.key,
    this.data = HomeMockData.flashSale,
    this.onViewAll,
    this.onProductTap,
    this.onBuyNow,
  });

  final FlashSaleData data;
  final VoidCallback? onViewAll;
  final ValueChanged<ShopProduct>? onProductTap;
  final ValueChanged<ShopProduct>? onBuyNow;

  @override
  Widget build(BuildContext context) {
    if (data.products.isEmpty) return const SizedBox.shrink();

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFE1BA), Color(0xFFFFF8F0), Color(0xFFFFE8CB)],
          stops: [0, 0.55, 1],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.centerStart,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/ic_flash_sale.svg',
                            width: 24.r,
                            height: 24.r,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'FLASH SALE',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF212B36),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          _FlashSaleCountdown(
                            remainingTime: data.remainingTime,
                          ),
                        ],
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
                              color: _flashAccent,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          SvgPicture.asset(
                            'assets/svgs/ic_arrow.svg',
                            width: 12.r,
                            height: 12.r,
                            colorFilter: const ColorFilter.mode(
                              _flashAccent,
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
              height: 340.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: data.products.length,
                separatorBuilder: (_, _) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final product = data.products[index];
                  final onTap = onProductTap;
                  final onBuy = onBuyNow;

                  return SizedBox(
                    width: 148.w,
                    child: ProductCard(
                      product: product,
                      showSaleProgress: true,
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

class _FlashSaleCountdown extends StatefulWidget {
  const _FlashSaleCountdown({required this.remainingTime});

  final Duration remainingTime;

  @override
  State<_FlashSaleCountdown> createState() => _FlashSaleCountdownState();
}

class _FlashSaleCountdownState extends State<_FlashSaleCountdown>
    with WidgetsBindingObserver {
  Timer? _timer;
  late DateTime _endsAt;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    _remaining = widget.remainingTime.isNegative
        ? Duration.zero
        : widget.remainingTime;
    _endsAt = DateTime.now().add(_remaining);
    if (_remaining > Duration.zero) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
    }
  }

  void _updateTime() {
    final difference = _endsAt.difference(DateTime.now());
    final remaining = difference.isNegative
        ? Duration.zero
        : Duration(
            seconds:
                (difference.inMicroseconds / Duration.microsecondsPerSecond)
                    .ceil(),
          );
    if (remaining == Duration.zero) _timer?.cancel();
    if (remaining.inSeconds != _remaining.inSeconds) {
      setState(() => _remaining = remaining);
    }
  }

  @override
  void didUpdateWidget(covariant _FlashSaleCountdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remainingTime != widget.remainingTime) _startCountdown();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final values = [
      _remaining.inHours,
      _remaining.inMinutes.remainder(60),
      _remaining.inSeconds.remainder(60),
    ];

    return Semantics(
      label: 'Còn ${values[0]} giờ ${values[1]} phút ${values[2]} giây',
      child: ExcludeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var index = 0; index < values.length; index++) ...[
              if (index > 0)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text(
                    ':',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFFEF3535),
                    ),
                  ),
                ),
              Container(
                width: 25.w,
                height: 26.h,
                padding: EdgeInsets.fromLTRB(1.r, 2.r, 1.r, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Color(0xFFEF3535)],
                  ),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF3535),
                    borderRadius: BorderRadius.circular(1.r),
                  ),
                  child: Center(
                    child: Text(
                      values[index].toString().padLeft(2, '0'),
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
