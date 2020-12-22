import 'package:flower_ui/models/shop.dart';
import 'package:flower_ui/models/store.product.dart';

class ShopProduct{
  int _id;
  bool _isEmpty;
  int _storeProductId;
  int _shopId;
  StoreProduct _storeProduct;
  Shop _shop;

  ShopProduct(this._id, this._isEmpty, this._storeProductId, this._shopId, 
   this._storeProduct, this._shop);

  int get id => _id;
  bool get isEmpty => _isEmpty;
  int get storeProductId => _storeProductId;
  int get shopId => _shopId;
  StoreProduct get storeProduct => _storeProduct;
  Shop get shop => _shop;

  set isEmpty(bool isEmpty){
    _isEmpty = isEmpty;
  }
  set storeProductId(int description){
    _storeProductId = storeProductId;
  }
  set shopId(int shopId){
    _shopId = shopId;
  }
  set storeProduct(StoreProduct storeProduct){
    _storeProduct = storeProduct;
  }
  set shop(Shop shop){
    _shop = shop;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["isEmpty"] = _isEmpty;
    map["storeProductId"] = _storeProductId;
    map["shopId"] = _shopId;
    map["storeProduct"] = _storeProduct;
    map["shop"] = _shop;

    return map;
  }

  ShopProduct.fromObject(dynamic object){
    this._id = object["id"];
    this._isEmpty = object["isEmpty"];
    this._storeProductId = object["storeProductId"];
    this._shopId = object["shopId"];
    this._storeProduct = object["storeProduct"];
    this._shop = object["shop"];
  }
}