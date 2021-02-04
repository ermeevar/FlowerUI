class ShopProduct{
  int _id;
  bool _isEmpty;
  int _storeProductId;
  int _shopId;

  ShopProduct();

  int get id => _id;
  bool get isEmpty => _isEmpty;
  int get storeProductId => _storeProductId;
  int get shopId => _shopId;

  set isEmpty(bool isEmpty){
    _isEmpty = isEmpty;
  }
  set storeProductId(int description){
    _storeProductId = storeProductId;
  }
  set shopId(int shopId){
    _shopId = shopId;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["isEmpty"] = _isEmpty;
    map["storeProductId"] = _storeProductId;
    map["shopId"] = _shopId;

    return map;
  }

  ShopProduct.fromObject(dynamic object){
    this._id = object["id"];
    this._isEmpty = object["isEmpty"];
    this._storeProductId = object["storeProductId"];
    this._shopId = object["shopId"];
  }
}