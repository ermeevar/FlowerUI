class Shop{
  int _id;
  String _address;
  int _storeId;

  int get id => _id;
  String get address => _address;
  int get storeId => _storeId;

  set id(int id){
    _id = id;
  }
  set address(String address){
    _address = address;
  }
  set storeId(int storeId){
    _storeId = storeId;
  }

  Shop(){}

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["address"] = _address;
    map["storeId"] = _storeId;

    return map;
  }

  Shop.fromObject(dynamic object){
    this._id = object["id"];
    this._address = object["address"];
    this._storeId = object["storeId"];
  }
}