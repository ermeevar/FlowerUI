class Order{
  int _id;
  String _name;
  String _state;

  Order(this._name, this._state);

  int get id => _id;
  String get name => _name;
  String get state => _state;

  set name(String name){
    _name = name;
  }
  set state(String state){
    _state = state;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["name"] = _name;
    map["state"] = _state;

    return map;
  }

  Order.fromObject(dynamic object){
    this._id = object["id"];
    this._name = object["name"];
    this._state = object["state"];
  }
}