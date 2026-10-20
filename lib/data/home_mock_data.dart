import 'models/home_models.dart';

/// Dữ liệu giả để dựng giao diện, không phải giá bán hay tồn kho thực tế.
///
/// Ảnh chưa có được để null. Khi thêm ảnh, đặt đường dẫn vào imageAsset/logoAsset.
class HomeMockData {
  HomeMockData._();

  static const cartItemCount = 12;

  static const recommendationBannerAsset = 'assets/images/ads_banner.png';

  // Tạm dùng cùng ảnh cho 3 slide để thử carousel.
  // Thay từng đường dẫn khi đã thêm ảnh banner quảng cáo vào assets/images/.
  static const carouselBannerImages = <String>[
    'assets/images/banner_small.png',
    'assets/images/banner_small.png',
    'assets/images/banner_small.png',
  ];

  static const categories = <ProductCategory>[
    ProductCategory(
      id: 'air-filter',
      name: 'Bộ Lọc Không Khí',
      groups: _sampleCategoryGroups,
      imageAsset: 'assets/images/cate-1.png'

    ),
    ProductCategory(
      id: 'oil-filter',
      name: 'Bộ Lọc Dầu',
      groups: _sampleCategoryGroups,
      imageAsset: 'assets/images/cate-2.png'
    ),
    ProductCategory(
      id: 'fuel-filter',
      name: 'Bộ Lọc Nhiên Liệu',
      groups: _sampleCategoryGroups,
      imageAsset: 'assets/images/cate-3.png'
    ),
    ProductCategory(
      id: 'cabin-filter',
      name: 'Bộ Lọc Trong Cabin',
      groups: _sampleCategoryGroups,
      imageAsset: 'assets/images/cate-4.png'
    ),
    ProductCategory(
      id: 'hydraulic-filter',
      name: 'Bộ Lọc Thủy Lực',
      groups: _sampleCategoryGroups,
      imageAsset: 'assets/images/cate-5.png'
    ),
  ];

  // Dùng chung nội dung hai nhóm để dựng bố cục demo như ảnh màn hình danh mục.
  static const _sampleCategoryGroups = <CategoryGroup>[
    CategoryGroup(
      id: 'sub-category-1',
      title: 'Sub Category 1',
      items: _sampleSubcategories,
    ),
    CategoryGroup(
      id: 'sub-category-2',
      title: 'Sub Category 2',
      items: _sampleSubcategories,
    ),
  ];

  static const _sampleSubcategories = <ProductCategory>[
    ProductCategory(
      id: 'round-air-filter',
      name: 'Bộ lọc gió',
      imageAsset: 'assets/images/cate-2.png',
    ),
    ProductCategory(
      id: 'cabin-cartridge',
      name: 'Bộ lọc trong cabin',
      imageAsset: 'assets/images/cate-3.png',
    ),
    ProductCategory(
      id: 'fuel-cartridge',
      name: 'Bộ lọc nhiên liệu',
      imageAsset: 'assets/images/cate-4.png',
    ),
    ProductCategory(
      id: 'oil-cartridge',
      name: 'Bộ lọc dầu động cơ',
      imageAsset: 'assets/images/cate-2.png',
    ),
    ProductCategory(
      id: 'spin-on-filter',
      name: 'Bộ lọc dầu dạng vặn',
      imageAsset: 'assets/images/cate-5.png',
    ),
    ProductCategory(
      id: 'truck-air-filter',
      name: 'Bộ lọc gió xe tải',
      imageAsset: 'assets/images/cate-1.png',
    ),
    ProductCategory(
      id: 'diesel-filter',
      name: 'Bộ lọc dầu diesel',
      imageAsset: 'assets/images/cate-3.png',
    ),
    ProductCategory(
      id: 'hydraulic-cartridge',
      name: 'Bộ lọc thủy lực',
      imageAsset: 'assets/images/cate-5.png',
    ),
    ProductCategory(
      id: 'panel-air-filter',
      name: 'Bộ lọc gió dạng tấm',
      imageAsset: 'assets/images/cate-1.png',
    ),
  ];

  static const brands = <ShopBrand>[
    ShopBrand(
      id: 'honda',
      name: 'Honda',
      logoAsset: 'assets/images/brand_honda.png',
    ),
    ShopBrand(
      id: 'ford',
      name: 'Ford',
      logoAsset: 'assets/images/brand_ford.png',
    ),
    ShopBrand(
      id: 'bmw',
      name: 'BMW',
      logoAsset: 'assets/images/brand_bmw.png',
    ),
    ShopBrand(
      id: 'audi',
      name: 'Audi',
      logoAsset: 'assets/images/brand_audi.png',
    ),
    ShopBrand(
      id: 'kia',
      name: 'KIA',
      logoAsset: 'assets/images/brand_kia.png',
    ),
    ShopBrand(
      id: 'nissan',
      name: 'Nissan',
      logoAsset: 'assets/images/brand_nissan.png',
    ),
    ShopBrand(
      id: 'chevrolet',
      name: 'Chevrolet',
      logoAsset: 'assets/images/brand_chevrolet.png',
    ),
    ShopBrand(
      id: 'volkswagen',
      name: 'Volkswagen',
      logoAsset: 'assets/images/brand_volkswagen.png',
    ),
    ShopBrand(
      id: 'lexus',
      name: 'Lexus',
      logoAsset: 'assets/images/brand_lexus.png',
    ),
    ShopBrand(
      id: 'volvo',
      name: 'Volvo',
      logoAsset: 'assets/images/brand_volvo.png',
    ),
  ];

  static const products = <ShopProduct>[
    ShopProduct(
      id: 'product-001',
      imageAsset: 'assets/images/cate-1.png',
      name: 'Lọc gió động cơ Air Filter - Chevrolet',
      categoryId: 'air-filter',
      brandId: 'chevrolet',
      priceVnd: 299000,
      originalPriceVnd: 329000,
      stock: 12,
      soldCount: 88,
    ),
    ShopProduct(
      id: 'product-002',
      imageAsset: 'assets/images/cate-2.png',
      name: 'Bộ lọc dầu động cơ - Honda',
      categoryId: 'oil-filter',
      brandId: 'honda',
      priceVnd: 189000,
      originalPriceVnd: 210000,
      stock: 1,
      soldCount: 126,
    ),
    ShopProduct(
      id: 'product-003',
      imageAsset: 'assets/images/cate-3.png',
      name: 'Bộ lọc nhiên liệu Fuel Filter - Ford',
      categoryId: 'fuel-filter',
      brandId: 'ford',
      priceVnd: 249000,
      originalPriceVnd: 279000,
      stock: 8,
      soldCount: 64,
    ),
    ShopProduct(
      id: 'product-004',
      imageAsset: 'assets/images/cate-4.png',
      name: 'Bộ lọc điều hòa Cabin Filter - BMW',
      categoryId: 'cabin-filter',
      brandId: 'bmw',
      priceVnd: 299000,
      originalPriceVnd: 329000,
      stock: 1,
      soldCount: 112,
    ),
    ShopProduct(
      id: 'product-005',
      imageAsset: 'assets/images/cate-1.png',
      name: 'Bộ lọc gió động cơ - KIA',
      categoryId: 'air-filter',
      brandId: 'kia',
      priceVnd: 159000,
      originalPriceVnd: 179000,
      stock: 1,
      soldCount: 95,
    ),
    ShopProduct(
      id: 'product-006',
      imageAsset: 'assets/images/cate-5.png',
      name: 'Bộ lọc dầu động cơ cao cấp - Volvo',
      categoryId: 'oil-filter',
      brandId: 'volvo',
      priceVnd: 399000,
      stock: 20,
      soldCount: 32,
    ),
  ];

  static const flashSale = FlashSaleData(
    remainingTime: Duration(hours: 19, minutes: 25),
    products: products,
  );

  static final bestSellingProducts = List<ShopProduct>.unmodifiable([
    products[1],
    products[3],
    products[4],
  ]);

  static final recommendedProducts = List<ShopProduct>.unmodifiable([
    products[0],
    products[2],
    products[3],
  ]);

  static final newArrivalProducts = List<ShopProduct>.unmodifiable([
    products[5],
    products[2],
    products[0],
  ]);

  static final articles = List<ShopArticle>.unmodifiable([
    ShopArticle(
      id: 'article-001',
      imageAsset: 'assets/images/cate-1.png',
      title:
          'Đầu phun sprinkler là gì? Cấu tạo, ứng dụng và nguyên lý hoạt động',
      publishedAt: DateTime(2025, 2, 13),
    ),
    ShopArticle(
      id: 'article-002',
      imageAsset: 'assets/images/cate-2.png',
      title: 'Các loại bộ lọc ô tô và cách lựa chọn cho từng dòng xe',
      publishedAt: DateTime(2025, 2, 13),
    ),
    ShopArticle(
      id: 'article-003',
      imageAsset: 'assets/images/cate-3.png',
      title: 'Khi nào cần thay lọc gió động cơ và lọc điều hòa ô tô?',
      publishedAt: DateTime(2025, 2, 13),
    ),
  ]);
}
