import 'dart:convert';

List<Bouquet> bouquetFromJson(String str) => List<Bouquet>.from(json.decode(str).map((x) => Bouquet.fromJson(x)));

String bouquetToJson(List<Bouquet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bouquet {
  Bouquet({
    this.id,
    this.name,
    this.cost,
    this.storeId,
    this.userId,
  });

  int id;
  String name;
  double cost;
  int storeId;
  int userId;

  factory Bouquet.fromJson(Map<String, dynamic> json) => Bouquet(
    id: json["id"],
    name: json["name"],
    cost: json["cost"].toDouble(),
    storeId: json["storeId"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "cost": cost.toDouble(),
    "storeId": storeId,
    "userId": userId,
  };
}
