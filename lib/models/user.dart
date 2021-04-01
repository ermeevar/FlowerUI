import 'dart:typed_data';

class User{
  int _id;
  String _surname;
  String _name;
  String _phone;
  Uint8List _picture;
  int _accountId;

  User();

  int get id => _id;
  String get surname => _surname;
  String get name => _name;
  String get phone => _phone;
  Uint8List get picture => _picture;
  int get accountId => _accountId;

  set id(int id){
    _id = id;
  }
  set surname(String surname){
    _surname = surname;
  }
  set name(String name){
    _name = name;
  }
  set phone(String phone){
    _phone = phone;
  }
  set picture(Uint8List picture){
    _picture = picture;
  }
  set accountId(int accountId){
    _accountId = accountId;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["surname"] = _surname;
    map["name"] = _name;
    map["phone"] = _phone;
    map["picture"] = _picture;
    map["accountId"] = _accountId;

    return map;
  }

  User.fromObject(dynamic object){
    this._id = object["id"];
    this._surname = object["surname"];
    this._name = object["name"];
    this._phone = object["phone"];
    this._picture = object["picture"];
    this._accountId = object["accountId"];
  }
}