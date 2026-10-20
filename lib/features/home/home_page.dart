import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_project/data/home_mock_data.dart';
import 'package:test_project/features/home/widgets/article_section.dart';
import 'package:test_project/features/home/widgets/banner_small_section.dart';
import 'package:test_project/features/home/widgets/best_seller_section.dart';
import 'package:test_project/features/home/widgets/brand_section.dart';
import 'package:test_project/features/home/widgets/category_section.dart';
import 'package:test_project/features/home/widgets/flash_sale_section.dart';
import 'package:test_project/features/home/widgets/new_arrivals_section.dart';
import 'package:test_project/features/home/widgets/promotion_section.dart';
import 'package:test_project/features/home/widgets/recommended_section.dart';

import 'package:test_project/data/models/home_models.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.onCategoryTap});

  final ValueChanged<ProductCategory>? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        key: const PageStorageKey('home-scroll'),
        children: [
          //banner
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Image.asset(
              'assets/images/banner_phu.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          // Danh mục tiêu biểu.
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: CategorySection(onCategoryTap: onCategoryTap),
          ),
          // Banner quảng cáo.
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: const BannerSmallSection(
              imageAssets: HomeMockData.carouselBannerImages,
            ),
          ),
          // Flash sale.
          SizedBox(height: 24.h),
          const FlashSaleSection(),
          // Thương hiệu nổi bật.
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: const BrandSection(),
          ),
          // Sản phẩm bán chạy.
          SizedBox(height: 24.h),
          const BestSellerSection(),
          // Khuyến mãi.
          SizedBox(height: 24.h),
          const PromotionSection(),
          // Dành cho bạn.
          SizedBox(height: 24.h),
          const RecommendedSection(),
          // Hàng mới về.
          SizedBox(height: 24.h),
          const NewArrivalsSection(),
          // Bài viết nổi bật.
          SizedBox(height: 24.h),
          const ArticleSection(),
        ],
      ),
    );
  }
}
