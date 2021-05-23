import 'dart:convert';

import 'dart:typed_data';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.name,
    this.picture,
    this.cost,
    this.productCategoryId,
    this.storeId,
  });

  int id;
  String name;
  Uint8List picture;
  double cost;
  int productCategoryId;
  int storeId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    picture: json["picture"],
    cost: json["cost"].toDouble(),
    productCategoryId: json["productCategoryId"],
    storeId: json["storeId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "picture": picture,
    "cost": cost,
    "productCategoryId": productCategoryId,
    "storeId": storeId,
  };

  Map<String, dynamic> toJsonUpdate() => {
    "id": id,
    "name": name,
    "picture": picture,
    "cost": cost,
    "productCategoryId": productCategoryId,
    "storeId": storeId,
  };
}
