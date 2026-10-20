import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/themes/app_color.dart';
import '../../../data/home_mock_data.dart';
import '../../../data/models/home_models.dart';
import 'home_section_header.dart';

class ArticleSection extends StatelessWidget {
  const ArticleSection({
    super.key,
    this.articles,
    this.onViewAll,
    this.onArticleTap,
  });

  final List<ShopArticle>? articles;
  final VoidCallback? onViewAll;
  final ValueChanged<ShopArticle>? onArticleTap;

  @override
  Widget build(BuildContext context) {
    final items = articles ?? HomeMockData.articles;
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeSectionHeader(
            title: 'Bài Viết Nổi Bật',
            iconAsset: 'assets/svgs/ic_article.svg',
            onViewAll: onViewAll,
          ),
          SizedBox(height: 16.h),
          for (var index = 0; index < items.length; index++) ...[
            if (index > 0) SizedBox(height: 12.h),
            _ArticleItem(
              article: items[index],
              onTap: onArticleTap == null
                  ? null
                  : () => onArticleTap!(items[index]),
            ),
          ],
        ],
      ),
    );
  }
}

class _ArticleItem extends StatelessWidget {
  const _ArticleItem({required this.article, this.onTap});

  final ShopArticle article;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final imageAsset = article.imageAsset;
    final date = article.publishedAt;
    final dateLabel =
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          // Giữ chiều cao hàng đồng bộ với cỡ chữ và chiều rộng ảnh.
          height: 88.w,
          child: Padding(
            padding: EdgeInsets.all(4.r),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: SizedBox(
                    width: 100.w,
                    height: double.infinity,
                    child: imageAsset == null
                        ? ColoredBox(
                            color: const Color(0xFFF0F3F5),
                            child: Icon(
                              Icons.article_outlined,
                              size: 32.r,
                              color: const Color(0xFF919EAB),
                            ),
                          )
                        : Image.asset(imageAsset, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF212B36),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          dateLabel,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
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
