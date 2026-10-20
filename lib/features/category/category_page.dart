import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/themes/app_color.dart';
import '../../data/home_mock_data.dart';
import '../../data/models/home_models.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    super.key,
    required this.selectedCategoryId,
    required this.onCategorySelected,
    this.categories = HomeMockData.categories,
    this.onGroupTap,
  });

  final String selectedCategoryId;
  final ValueChanged<ProductCategory> onCategorySelected;
  final List<ProductCategory> categories;
  final ValueChanged<CategoryGroup>? onGroupTap;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _contentController = ScrollController();

  @override
  void didUpdateWidget(covariant CategoryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategoryId != widget.selectedCategoryId &&
        _contentController.hasClients) {
      _contentController.jumpTo(0);
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) return const SizedBox.shrink();
    final selected = widget.categories.firstWhere(
      (category) => category.id == widget.selectedCategoryId,
      orElse: () => widget.categories.first,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 88.w,
          child: ColoredBox(
            color: const Color(0xFFE6F1FF),
            child: ListView.builder(
              key: const PageStorageKey('category-sidebar'),
              padding: EdgeInsets.zero,
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                final category = widget.categories[index];
                final isSelected = category.id == selected.id;

                return Semantics(
                  selected: isSelected,
                  child: Material(
                    key: ValueKey('category-${category.id}'),
                    color: isSelected
                        ? const Color(0xFFF7F8FA)
                        : const Color(0xFFE6F1FF),
                    borderRadius: BorderRadius.circular(16.r),
                    child: InkWell(
                      onTap: () => widget.onCategorySelected(category),
                      borderRadius: BorderRadius.circular(16.r),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(12.w, 14.h, 8.w, 14.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 44.r,
                              height: 40.h,
                              child: _CategoryImage(category: category),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              category.name,
                              style: TextStyle(
                                fontSize: 12.sp,
                                height: 1.3,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? const Color(0xFF212B36)
                                    : const Color(0xFF004A9E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: CustomScrollView(
            key: const PageStorageKey('category-content'),
            controller: _contentController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              key: const ValueKey('category-title'),
                              selected.name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF212B36),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          SvgPicture.asset(
                            'assets/svgs/ic_arrow_cate.svg',
                            width: 7.w,
                            height: 12.h,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      const Divider(height: 1, color: Color(0xFFDFE3E8)),
                    ],
                  ),
                ),
              ),
              for (final group in selected.groups) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 12.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            group.title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF212B36),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: widget.onGroupTap == null
                              ? null
                              : () => widget.onGroupTap!(group),
                          child: Row(
                            children: [
                              Text(
                                'Xem tất cả',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              SvgPicture.asset(
                                'assets/svgs/ic_arrow.svg',
                                width: 10.r,
                                height: 10.r,
                                colorFilter: const ColorFilter.mode(
                                  AppColor.primaryColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 16.h),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 0.68,
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = group.items[index];
                      return Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: SizedBox(
                                width: double.infinity,
                                child: _CategoryImage(category: item),
                              ),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          SizedBox(
                            height: 48.w,
                            child: Text(
                              item.name,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12.sp, height: 1.3),
                            ),
                          ),
                        ],
                      );
                    }, childCount: group.items.length),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: const Divider(height: 1, color: Color(0xFFDFE3E8)),
                  ),
                ),
              ],
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryImage extends StatelessWidget {
  const _CategoryImage({required this.category});

  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    final asset = category.imageAsset;
    return asset == null
        ? Icon(
            Icons.filter_alt_outlined,
            size: 32.r,
            color: const Color(0xFF919EAB),
          )
        : Image.asset(asset, fit: BoxFit.contain);
  }
}
