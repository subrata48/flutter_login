class User {
  String mobile;
  String _password;
  String latitude;
  String longitude;

  String status;
  String msg;


  User(this.mobile, this.latitude,this.longitude,this._password);

  User.map(dynamic obj) {
    this.mobile = obj["mobile"];
    this.latitude = obj["latitude"];
    this.longitude = obj["longitude"];
    this._password = obj["password"];
  }

//  User.map(dynamic obj) {
//    this.status = obj["status"];
//    this.msg = obj["msg"];
//  }

  String get mobileda => mobile;
  String get password => _password;
  String get lat => latitude;
  String get long => longitude;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["mobile"] = mobile;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["password"] = _password;
    return map;
  }
}
