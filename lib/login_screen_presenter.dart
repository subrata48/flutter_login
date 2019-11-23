import 'dart:convert';

import 'package:flutter_app123/Data/rest_ds.dart';
import 'package:flutter_app123/Models/user.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(String user);

  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  RestDatasource api = new RestDatasource();

  LoginScreenPresenter(this._view);

  doLogin(String username, String password) {
    api.login(username, password).then((String jsondata) {
      var parsedJson = json.decode(jsondata);
      var status = parsedJson['status'];

      var msg = parsedJson['msg'];
      if (status == 0) {
        _view.onLoginError(msg);
      }else {
        _view.onLoginSuccess(msg);
      }
    }).catchError((Exception error) => _view.onLoginError(error.toString()));
  }
}
