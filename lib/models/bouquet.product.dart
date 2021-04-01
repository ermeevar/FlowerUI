import 'dart:convert';

List<BouquetProduct> bouquetProductFromJson(String str) => List<BouquetProduct>.from(json.decode(str).map((x) => BouquetProduct.fromJson(x)));

String bouquetProductToJson(List<BouquetProduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class BouquetProduct {
  BouquetProduct({
    this.id,
    this.productId,
    this.bouquetId,
  });

  int id;
  int productId;
  int bouquetId;

  factory BouquetProduct.fromJson(Map<String, dynamic> json) => BouquetProduct(
    id: json["id"],
    productId: json["productId"],
    bouquetId: json["bouquetId"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "bouquetId": bouquetId,
  };
}
