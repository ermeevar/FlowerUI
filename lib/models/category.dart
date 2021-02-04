class Category{
  int _id;
  String _name;

  Category();

  int get id => _id;
  String get name => _name;

  set name(String name){
    _name = name;
  }

   Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["name"] = _name;

    return map;
  }

  Category.fromObject(dynamic object){
    this._id = object["id"];
    this._name = object["name"];
  }
}