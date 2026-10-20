import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/themes/app_color.dart';
import '../../../data/home_mock_data.dart';
import '../../../data/models/home_models.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({
    super.key,
    this.categories = HomeMockData.categories,
    this.onCategoryTap,
  });

  final List<ProductCategory> categories;
  final ValueChanged<ProductCategory>? onCategoryTap;

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onCategoryTap = widget.onCategoryTap;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Danh mục tiêu biểu',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 98.h,
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            separatorBuilder: (_, _) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final category = widget.categories[index];

              return SizedBox(
                width: 80.w,
                child: _CategoryItem(
                  category: category,
                  onTap: onCategoryTap == null
                      ? null
                      : () => onCategoryTap(category),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        Center(
          child: AnimatedBuilder(
            animation: _scrollController,
            child: Container(
              width: 24.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            builder: (context, thumb) {
              var progress = 0.0;
              if (_scrollController.hasClients) {
                final position = _scrollController.position;
                if (position.hasContentDimensions &&
                    position.maxScrollExtent > position.minScrollExtent) {
                  progress =
                      ((position.pixels - position.minScrollExtent) /
                              (position.maxScrollExtent -
                                  position.minScrollExtent))
                          .clamp(0.0, 1.0);
                }
              }

              return Container(
                width: 60.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFDFE3E8),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Align(
                  alignment: AlignmentDirectional(-1 + 2 * progress, 0),
                  child: thumb,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({required this.category, this.onTap});

  final ProductCategory category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final imageAsset = category.imageAsset;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: imageAsset == null
                      ? Icon(
                          Icons.filter_alt_outlined,
                          size: 40.r,
                          color: const Color(0xFF919EAB),
                        )
                      : Image.asset(
                          imageAsset,
                          height: 50.h,
                          width: 50.w,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              SizedBox(height: 4.h),
              Center(
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
