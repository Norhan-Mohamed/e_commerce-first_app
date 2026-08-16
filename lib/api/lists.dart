import 'package:e_commerce/api/products.dart';

class Lists {
  late String? searchTerm;
  late String? categoryName;
  late int? itemCount;
  late String? redirectUrl;
  late List<Product> products;

  Lists({
    required this.searchTerm,
    required this.categoryName,
    required this.itemCount,
    required this.redirectUrl,
    required this.products,
  });

  Lists.fromMap(Map<String, dynamic> map) {
    searchTerm = map['searchTerm'];
    categoryName = map['categoryName'];
    itemCount = map['itemCount'];
    redirectUrl = map['redirectUrl'];
    products = [];
    for (final element in (map['products'] as List)) {
      products.add(Product.fromMap(element));
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "searchTerm": searchTerm,
      "categoryName": categoryName,
      "itemCount": itemCount,
      "redirectUrl": redirectUrl,
      "products": products,
    };
  }
}
