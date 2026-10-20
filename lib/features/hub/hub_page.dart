import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/themes/app_color.dart';
import '../../core/cubit/tab_navigator_cubit.dart';
import '../../data/home_mock_data.dart';
import '../../data/models/home_models.dart';
import '../category/category_page.dart';
import '../home/home_page.dart';
import '../home/widgets/article_section.dart';
import 'widgets/hub_bottom_bar.dart';
import 'widgets/hub_search_header.dart';

@RoutePage()
class HubPage extends StatelessWidget {
  const HubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TabNavigatorCubit(),
      child: const _HubView(),
    );
  }
}

class _HubView extends StatefulWidget {
  const _HubView();

  @override
  State<_HubView> createState() => _HubViewState();
}

class _HubViewState extends State<_HubView> {
  final _searchController = TextEditingController();
  String _selectedCategoryId = HomeMockData.categories.first.id;

  void _changeTab(int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<TabNavigatorCubit>().changeNavigator(index);
  }

  void _selectCategory(ProductCategory category) {
    setState(() => _selectedCategoryId = category.id);
  }

  void _openCategory(ProductCategory category) {
    _selectCategory(category);
    _changeTab(2);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabNavigatorCubit, int>(
      builder: (context, index) {
        return PopScope(
          canPop: index == 0,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) _changeTab(0);
          },
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
            ),
            child: Scaffold(
              backgroundColor: AppColor.primaryColor,
              body: Column(
                children: [
                  HubSearchHeader(
                    controller: _searchController,
                    showBackButton: index != 0,
                    onBack: () => _changeTab(0),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.r),
                      ),
                      child: ColoredBox(
                        color: const Color(0xFFF7F8FA),
                        child: IndexedStack(
                          index: index,
                          children: [
                            HomePage(onCategoryTap: _openCategory),
                            const _HubInfoTab(
                              iconAsset: 'assets/svgs/ic_hub_cart.svg',
                              title: 'Giỏ hàng',
                              message: '12 sản phẩm trong giỏ hàng mẫu',
                            ),
                            CategoryPage(
                              selectedCategoryId: _selectedCategoryId,
                              onCategorySelected: _selectCategory,
                            ),
                            ListView(
                              key: const PageStorageKey('articles-scroll'),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              children: const [ArticleSection()],
                            ),
                            const _HubInfoTab(
                              iconAsset: 'assets/svgs/ic_hub_user.svg',
                              title: 'Tài khoản',
                              message:
                                  'Đăng nhập để quản lý tài khoản và đơn hàng',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: HubBottomBar(
                currentIndex: index,
                onTap: _changeTab,
                cartCount: HomeMockData.cartItemCount,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HubInfoTab extends StatelessWidget {
  const _HubInfoTab({
    required this.iconAsset,
    required this.title,
    required this.message,
  });

  final String iconAsset;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconAsset,
              width: 24.r,
              height: 24.r,
              colorFilter: const ColorFilter.mode(
                AppColor.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: const Color(0xFF637381)),
            ),
          ],
        ),
      ),
    );
  }
}
