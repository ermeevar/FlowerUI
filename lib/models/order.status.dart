import 'dart:convert';


List<OrderStatus> orderStatusFromJson(String str) => List<OrderStatus>.from(json.decode(str).map((x) => OrderStatus.fromJson(x)));

String orderStatusToJson(List<OrderStatus> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderStatus {
  OrderStatus({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}