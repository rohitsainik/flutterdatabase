class User {
  String _username;
  String _id;
  String _password;

  User(this._username,this._password, [this._id]);

  User.map(dynamic, obj) {
    this._username = obj["username"];
    this._password = obj["password"];
    this._id = obj["id"];
  }

  String get Username => _username;

  String get Password => _password;

  String get Id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._username = map["username"];
    this._id = map["id"];
    this._password = map["password"];
  }
}
