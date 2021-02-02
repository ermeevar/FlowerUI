import 'package:flower_ui/models/store.dart';
import 'package:flower_ui/models/category.dart';

class StoreProduct{
  int _id;
  String _name;
  List<double> _picture;
  double _cost;
  int _categoryId;
  int _storeId;

  int get id => _id;
  String get name => _name;
  List<double> get picture => _picture;
  double get cost => _cost;
  int get categoryId => _categoryId;
  int get storeId => _storeId;

  set name(String name){
    _name = name;
  }
  set picture(List<double> picture){
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

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["name"] = _name;
    map["picture"] = _picture;
    map["cost"] = _cost;
    map["categoryId"] = _categoryId;
    map["storeId"] = _storeId;

    return map;
  }

  StoreProduct.fromObject(dynamic object){
    this._id = object["id"];
    this._name = object["name"];
    this._picture = object["picture"];
    this._cost = object["cost"];
    this._categoryId = object["categoryId"];
    this._storeId = object["storeId"];

    print(_id);
    print(_name);
    print(_picture);
    print(_cost);
    print(_categoryId);
    print(_storeId);
  }
}
