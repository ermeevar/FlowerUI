class StoreProduct{
  int _id=0;
  String _name;
  List<int> _picture = [];
  double _cost =0;
  int _categoryId =0;
  int _storeId =0;

  StoreProduct();

  int get id => _id;
  String get name => _name;
  List<int> get picture => _picture;
  double get cost => _cost;
  int get categoryId => _categoryId;
  int get storeId => _storeId;

  set id(int id){
    _id = id;
  }
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
    this._cost = object["cost"].toDouble();
    this._categoryId = object["categoryId"];
    this._storeId = object["storeId"];
  }
}
