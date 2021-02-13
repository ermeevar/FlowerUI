import 'dart:convert';

List<Shop> shopFromJson(String str) => List<Shop>.from(json.decode(str).map((x) => Shop.fromJson(x)));

String shopToJson(List<Shop> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Shop {
  Shop({
    this.id,
    this.address,
    this.storeId,
    this.accountId,
  });

  int id;
  String address;
  int storeId;
  int accountId;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"],
    address: json["address"],
    storeId: json["storeId"],
    accountId: json["accountId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "storeId": storeId,
    "accountId": accountId,
  };
}