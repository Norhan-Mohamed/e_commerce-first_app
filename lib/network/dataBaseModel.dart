const String columnname = 'name';
const String columnid = 'id';
const String columnimageUrl = 'imageUrl';
const String columncolour = 'colour';
const String columncolourWayId = 'colourWayId';
const String columnbrandName = 'brandName';
const String columnprice = 'price';

class DataBaseModel {
  int? id;
  late String name;
  late String colour;
  late int colourWayId;
  late String brandName;
  late String imageUrl;
  late double? price;

  DataBaseModel({
    required this.id,
    required this.name,
    required this.colour,
    required this.imageUrl,
    required this.brandName,
    required this.colourWayId,
    required this.price,
  });

  DataBaseModel.fromMap(Map<String, dynamic> map) {
    if (map[columnid] != null) {
      id = map[columnid];
    }
    name = map[columnname];
    colour = map[columncolour];
    imageUrl = map[columnimageUrl];
    brandName = map[columnbrandName];
    price = map[columnprice] is int
        ? (map[columnprice] as int).toDouble()
        : map[columnprice];
    colourWayId = int.parse(map[columncolourWayId].toString());
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (id != null) {
      map[columnid] = id;
    }

    map[columnname] = name;
    map[columncolour] = colour;
    map[columnimageUrl] = imageUrl;
    map[columnbrandName] = brandName;
    map[columncolourWayId] = colourWayId;
    map[columnprice] = price;

    return map;
  }
}
