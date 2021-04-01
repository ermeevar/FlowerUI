import 'dart:convert';


List<Store> storeFromJson(String str) => List<Store>.from(json.decode(str).map((x) => Store.fromJson(x)));

String storeToJson(List<Store> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Store {
  Store({
    this.id,
    this.name,
    this.description,
    this.picture,
    this.firstPhone,
    this.secondPhone,
    this.accountId,
  });

  int id;
  String name;
  String description;
  List<int> picture;
  String firstPhone;
  String secondPhone;
  int accountId;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    picture: json["picture"],
    firstPhone: json["firstPhone"],
    secondPhone: json["secondPhone"],
    accountId: json["accountId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description.toString(),
    "picture": picture.toList(),
    "firstPhone": firstPhone,
    "secondPhone": secondPhone,
    "accountId": accountId,
  };
}
