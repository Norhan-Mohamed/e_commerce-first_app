import 'package:e_commerce/api/price.dart';

class Product {
  late int id;
  late String name;
  late Price price;
  late String colour;
  late int colourWayId;
  late String brandName;
  late bool hasVariantColours;
  late bool hasMultiplePrices;
  late int productCode;
  late String productType;
  late String url;
  late String imageUrl;
  late bool isSellingFast;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.colour,
    required this.url,
    required this.brandName,
    required this.colourWayId,
    required this.hasMultiplePrices,
    required this.hasVariantColours,
    required this.imageUrl,
    required this.isSellingFast,
    required this.productCode,
    required this.productType,
  });

  Product.fromMap(Map<String, dynamic> map) {
    productType = map['productType'];
    id = map['id'];
    name = map['name'];
    price = Price.fromMap(map['price']);
    colour = map['colour'];
    url = map['url'];
    brandName = map['brandName'];
    colourWayId = map['colourWayId'];
    hasMultiplePrices = map['hasMultiplePrices'];
    hasVariantColours = map['hasVariantColours'];
    imageUrl = map['imageUrl'];
    isSellingFast = map['isSellingFast'];
    productCode = map['productCode'];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "price": price.toMap(),
      "colour": colour,
      "url": url,
      "brandName": brandName,
      "colourWayId": colourWayId,
      "hasMultiplePrices": hasMultiplePrices,
      "hasVariantColours": hasVariantColours,
      "imageUrl": imageUrl,
      "isSellingFast": isSellingFast,
      "productCode": productCode,
      "productType": productType,
    };
  }
}
