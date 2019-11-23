class User {
//  String mobile;
//  String password;
//  String latitude;
//  String longitude;

  int status;
  String msg;


  User({this.status, this.msg});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      status: json['status'] as int,
      msg: json['msg'] as String,
    );
  }

//  User.map(dynamic obj) {
//    this.status = obj["status"];
//    this.msg = obj["msg"];
//  }



  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["status"] = status;
    map["msg"] = msg;
    return map;
  }
}
