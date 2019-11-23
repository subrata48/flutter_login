import 'dart:async';
import 'dart:convert';
import 'package:flutter_app123/Utils/network_util.dart';
import 'package:flutter_app123/Models/user.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://vervedeveloper.com/DOW";
  static final LOGIN_URL = BASE_URL +"/loginApi.php";
  static final _API_KEY = "2345";

  Future<String> login(String username, String password) {
    return _netUtil.createPost(LOGIN_URL, body: {
      "mobile": username,
      "latitude": "345.56",
      "longitude": "234.45",
      "password": password
    }).then((dynamic res) {
      print("retstd"+res.toString());
      return res.toString();
    });



  }
}

