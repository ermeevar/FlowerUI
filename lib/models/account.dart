class Account{
  int _id;
  String _login;
  String _passwordHash;
  String _salt;
  String _role;

  int get id => _id;
  String get login => _login;
  String get passwordHash => _passwordHash;
  String get salt => _salt;
  String get role => _role;

  Account(){}

  set id(int id){
    _id = id;
  }
  set login(String login){
    _login = login;
  }
  set passwordHash(String passwordHash){
    _passwordHash = passwordHash;
  }
  set salt(String salt){
    _salt = salt;
  }
  set role(String role){
    _role = role;
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map["id"] = _id;
    map["login"] = _login;
    map["passwordHash"] = _passwordHash;
    map["salt"] = _salt;
    map["role"] = _role;

    return map;
  }

  Account.fromObject(dynamic object){
    this._id = object["id"];
    this._login = object["login"];
    this._passwordHash = object["passwordHash"];
    this._salt = object["salt"];
    this._role = object["role"];
    //
    // print(_id);
    // print(_name);
    // print(_description);
    // print(_picture);
    // print(_firstPhone);
    // print(_secondPhone);
  }
}