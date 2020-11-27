import 'package:flower_ui/models/store.dart';
import 'package:flower_ui/models/category.dart';

class StoreProduct{
  int _id;
  String _name;
  List<int> _picture;
  double _cost;
  int _categoryId;
  int _storeId;
  Category _category;
  Store _store;

  StoreProduct(this._id, this._name, this._picture, this._cost,
   this._categoryId, this._storeId, this._category, this._store);

  int get id => _id;
  String get name => _name;
  List<int> get picture => _picture;
  double get cost => _cost;
  int get categoryId => _categoryId;
  int get storeId => _storeId;
  Category get category => _category;
  Store get store => _store;

  set name(String name){
    _name = name;
  }
  set picture(List<int> picture){
    _picture = picture;
  }
  set cost(double cost){
    _cost = cost;
  }
  set categoryId(int categoryId){
    _categoryId = categoryId;
  }
  set storeId(int storeId){
    _storeId = storeId;
  }
  set category(Category category){
    _category = category;
  }
  set store(Store store){
    _store = store;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["name"] = _name;
    map["picture"] = _picture;
    map["cost"] = _cost;
    map["categoryId"] = _categoryId;
    map["storeId"] = _storeId;
    map["category"] = _category;
    map["store"] = _store;

    return map;
  }

  StoreProduct.fromObject(dynamic object){
    this._id = object["id"];
    this._name = object["name"];
    this._picture = object["picture"];
    this._cost = object["cost"];
    this._categoryId = object["categoryId"];
    this._storeId = object["storeId"];
    this._category = object["category"];
    this._store = object["store"];
  }
}
