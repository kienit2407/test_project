/// Dữ liệu dùng để dựng các section của trang chủ và màn hình danh mục.
///
/// [imageAsset] và [logoAsset] nhận đường dẫn asset khi đã có ảnh thiết kế.
/// Giá tiền được lưu bằng số nguyên theo đơn vị đồng, chưa format cho giao diện.
class ProductCategory {
  const ProductCategory({
    required this.id,
    required this.name,
    this.imageAsset,
    this.groups = const [],
  });

  final String id;
  final String name;
  final String? imageAsset;
  final List<CategoryGroup> groups;
}

class CategoryGroup {
  const CategoryGroup({
    required this.id,
    required this.title,
    required this.items,
  });

  final String id;
  final String title;
  final List<ProductCategory> items;
}

class ShopProduct {
  const ShopProduct({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.brandId,
    required this.priceVnd,
    required this.stock,
    this.originalPriceVnd,
    this.soldCount = 0,
    this.imageAsset,
  });

  final String id;
  final String name;
  final String categoryId;
  final String brandId;
  final String? imageAsset;
  final int priceVnd;
  final int? originalPriceVnd;
  final int stock;
  final int soldCount;

  int get discountPercent {
    final original = originalPriceVnd;
    if (original == null || original <= 0 || priceVnd >= original) return 0;
    return ((original - priceVnd) / original * 100).round();
  }
}

class ShopBrand {
  const ShopBrand({required this.id, required this.name, this.logoAsset});

  final String id;
  final String name;
  final String? logoAsset;
}


class FlashSaleData {
  const FlashSaleData({required this.remainingTime, required this.products});

  /// Giá trị demo cho đồng hồ; chưa phải thời gian kết thúc của một sự kiện thật.
  final Duration remainingTime;
  final List<ShopProduct> products;
}

class ShopArticle {
  const ShopArticle({
    required this.id,
    required this.title,
    required this.publishedAt,
    this.imageAsset,
  });

  final String id;
  final String title;
  final DateTime publishedAt;
  final String? imageAsset;
}
