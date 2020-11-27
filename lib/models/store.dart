import 'package:flutter/material.dart';

class Store{
  int _id;
  String _name;
  String _description;
  List<int> _picture;
  BigInt _firstPhone;
  BigInt _secondPhone;

  Store(this._id, this._name, this._description, this._picture, this._firstPhone, this._secondPhone);

  int get id => _id;
  String get name => _name;
  String get description => _description;
  List<int> get picture => _picture;
  BigInt get firstPhone => _firstPhone;
  BigInt get secondPhone => _secondPhone;

  set name(String name){
    _name = name;
  }
  set description(String description){
    _description = description;
  }
  set picture(List<int> picture){
    _picture = picture;
  }
  set firstPhone(BigInt firstPhone){
    _firstPhone = firstPhone;
  }
  set secondPhone(BigInt secondPhone){
    _secondPhone = secondPhone;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["name"] = _name;
    map["description"] = _description;
    map["picture"] = _picture;
    map["firstPhone"] = _firstPhone;
    map["secondPhone"] = _secondPhone;

    return map;
  }

  Store.fromObject(dynamic object){
    this._id = object["id"];
    this._name = object["name"];
    this._description = object["description"];
    this._picture = object["picture"];
    this._firstPhone = object["firsPhone"];
    this._secondPhone = object["secondPhone"];
  }
}