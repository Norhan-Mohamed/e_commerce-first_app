class Details {
  late int id;
  late String name;
  late String description;
  late String gender;
  late bool isInStock;

  Details({
    required this.id,
    required this.name,
    required this.description,
    required this.gender,
    required this.isInStock,
  });

  Details.FromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    description = map["description"] ?? '';
    gender = map["gender"] ?? '';
    isInStock = map["isInStock"] ?? false;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "gender": gender,
      "isInStock": isInStock,
    };
  }
}
