import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.id,
    this.surname,
    this.name,
    this.phone,
    this.picture,
    this.accountId,
  });

  int id;
  String surname;
  String name;
  String phone;
  dynamic picture;
  int accountId;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    surname: json["surname"],
    name: json["name"],
    phone: json["phone"],
    picture: json["picture"],
    accountId: json["accountId"],
  );

  Map<String, dynamic> toJson() => {
    "surname": surname,
    "name": name,
    "phone": phone,
    "picture": picture,
    "accountId": accountId,
  };

  Map<String, dynamic> toJsonUpdate() => {
    "id": id,
    "surname": surname,
    "name": name,
    "phone": phone,
    "picture": picture,
    "accountId": accountId,
  };
}
