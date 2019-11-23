import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
      ),
      body: SingleChildScrollView(
        child: Signupform(),
      ),
//      body: Center(
//        child: RaisedButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          child: Text('Go back!'),
//        ),
//      ),
    );
  }
}

class Signupform extends StatefulWidget {
  @override
  Signupformstate createState() {
    return Signupformstate();
  }
}

class Signupformstate extends State<Signupform> {
  final formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _autoValidate = false;
  SignUpRequestData sighnupData = SignUpRequestData();
  static final CREATE_POST_URL = 'https://jsonplaceholder.typicode.com/posts';
  TextEditingController titleControler = new TextEditingController();
  TextEditingController bodyControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      autovalidate: _autoValidate,
      child: new Container(
        margin: new EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          new SizedBox(height: 20.0),
          new Center(
            //margin: const EdgeInsets.only(left: 40),
            child: new Text(
              'Register To Flutter ',
              textAlign: TextAlign.center,
              style: new TextStyle(color: Colors.deepOrange, fontSize: 25.0),
            ),
          ),
          new SizedBox(height: 30.0),
          TextFormField(
            //obscureText: _obscureText,
            keyboardType: TextInputType.number,
            autofocus: false,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: 'Enter your PhoneNumber',

              //hintText: ' Email',
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              ),
            ),
            validator: validateMobile,
            onSaved: (String value) {
              sighnupData.number = value;
            },
          ),
          new SizedBox(height: 20.0),
          new TextFormField(
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
              labelText: 'Enter Your Name',
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              ),
            ),
            validator: validateName,
            onSaved: (String value) {
              sighnupData.name = value;
            },
          ),
          new SizedBox(height: 20.0),
          new TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            decoration: InputDecoration(
              labelText: 'Enter Your Email',
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              ),
            ),
            validator: validateEmail,
            onSaved: (String value) {
              sighnupData.email = value;
            },
          ),
          new SizedBox(height: 25.0),
          ButtonTheme(
            minWidth: 16.0,
            height: 35.0,
            child: RaisedButton(
              //onPressed: null,
              //child: new Text('Validate'),
              onPressed:getregister,


              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,

                //`mainAxisAlignment: MainAxisAlignment.center` => Center Column contents vertically,
                children: <Widget>[
                  new Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      'SignUp',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

//                    Icon(
//                      Icons.keyboard_arrow_down,
//                      size: 20.0,
//                    ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future getregister() async {
    if (formkey.currentState.validate()) {
//    If all data are correct then save data to out variables
      formkey.currentState.save();
      print("Validate");
      Toast.show("Validate Succsses", context,
          backgroundColor: Colors.deepOrange,
          textColor: Colors.white,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);

      Post newPost = new Post(
          userId: "123",
          id: 0,
          title: titleControler.text,
          body: bodyControler.text);
      Post p = await createPost(CREATE_POST_URL, body: newPost.toMap());
      print(p.title);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
}

class SignUpRequestData {
  String name = '';
  String email = '';
  String number = '';
}

String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
  if (value.length != 10)
    return 'Mobile Number must be of 10 digit';
  else
    return null;
}

String validateName(String value) {
  if (value.length < 3)
    return 'Name must be more than 2 charater';
  else
    return null;
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.isEmpty) {
    return "Email is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return null;
  }
}

class Post {
  final String userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["userId"] = userId;
    map["title"] = title;
    map["body"] = body;

    return map;
  }
}

Future<Post> createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}
