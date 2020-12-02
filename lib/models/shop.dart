import 'package:flower_ui/models/store.dart';

class Shop{
  int _id;
  String _address;
  int _storeId;
  Store _store;

  Shop(this._address, this._storeId, this._store);

  int get id => _id;
  String get address => _address;
  int get storeId => _storeId;
  Store get store => _store;

  set address(String address){
    _address = address;
  }
  set storeId(int storeId){
    _storeId = storeId;
  }
  set store(Store store){
    _store = store;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["address"] = _address;
    map["storeId"] = _storeId;
    map["store"] = _store;

    return map;
  }

  Shop.fromObject(dynamic object){
    this._id = object["id"];
    this._address = object["address"];
    this._storeId = object["storeId"];
    this._store = object["store"];
  }
}