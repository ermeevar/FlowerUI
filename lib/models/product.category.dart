import 'dart:convert';

List<ProductCategory> productCategoryFromJson(String str) => List<ProductCategory>.from(json.decode(str).map((x) => ProductCategory.fromJson(x)));

String productCategoryToJson(List<ProductCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductCategory {
  ProductCategory({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
