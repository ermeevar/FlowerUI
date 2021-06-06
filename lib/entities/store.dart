import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

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
  Uint8List picture;
  String firstPhone;
  String secondPhone;
  int accountId;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    picture: json["picture"] != null? base64.decode(json["picture"]) : json["picture"],
    firstPhone: json["firstPhone"],
    secondPhone: json["secondPhone"],
    accountId: json["accountId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description.toString(),
    "picture": picture,
    "firstPhone": firstPhone,
    "secondPhone": secondPhone,
    "accountId": accountId,
  };

  Map<String, dynamic> toJsonUpdate() => {
    "id": id,
    "name": name,
    "description": description.toString(),
    "picture": picture != null? base64.encode(picture) : null,
    "firstPhone": firstPhone,
    "secondPhone": secondPhone,
    "accountId": accountId,
  };
}
