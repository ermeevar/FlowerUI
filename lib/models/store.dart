class Store{
  int _id;
  String _name;
  String _description;
  List<int> _picture;
  String _firstPhone;
  String _secondPhone;
  int _accountId;

  int get id => _id;
  String get name => _name;
  String get description => _description;
  List<int> get picture => _picture;
  String get firstPhone => _firstPhone;
  String get secondPhone => _secondPhone;
  int get accountId => _accountId;

  Store(){}

  set id(int id){
    _id = id;
  }
  set name(String name){
    _name = name;
  }
  set description(String description){
    _description = description;
  }
  set picture(List<int> picture){
    _picture = picture;
  }
  set firstPhone(String firstPhone){
    _firstPhone = firstPhone;
  }
  set secondPhone(String secondPhone){
    _secondPhone = secondPhone;
  }
  set accountId(int accountId){
    _accountId = accountId;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["name"] = _name;
    map["description"] = _description;
    map["picture"] = _picture;
    map["firstPhone"] = _firstPhone;
    map["secondPhone"] = _secondPhone;
    map["accountId"] = _accountId;

    return map;
  }

  Store.fromObject(dynamic object){
    this._id = object["id"];
    this._name = object["name"];
    this._description = object["description"];
    this._picture = object["picture"];
    this._firstPhone = object["firstPhone"];
    this._secondPhone = object["secondPhone"];
    this._accountId = object["accountId"];

    print(_id);
    print(_name);
    print(_description);
    print(_picture);
    print(_firstPhone);
    print(_secondPhone);
  }
}