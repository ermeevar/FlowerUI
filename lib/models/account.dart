import 'dart:convert';


List<Account> accountFromJson(String str) => List<Account>.from(json.decode(str).map((x) => Account.fromJson(x)));

String accountToJson(List<Account> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  Account({
    this.id,
    this.login,
    this.passwordHash,
    this.salt,
    this.role,
  });

  int id;
  String login;
  String passwordHash;
  dynamic salt;
  String role;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json["id"],
    login: json["login"],
    passwordHash: json["passwordHash"],
    salt: json["salt"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "login": login,
    "passwordHash": passwordHash,
    "salt": salt,
    "role": role,
  };
}
